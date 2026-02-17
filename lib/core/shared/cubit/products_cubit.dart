import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';
import 'package:products_api/core/shared/data/repos/api/api_repo.dart';
import 'package:products_api/core/shared/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ApiRepo repo;

  ProductsCubit(this.repo) : super(ProductsLoading());

  Future<void> loadProducts() async {
    emit(ProductsLoading());

    try {
      final List<ProductModel> products = await repo.loadProductsData();
      final List<ProductModel> favorites = await repo.getFavProducts();
      emit(ProductsLoaded(products: products, favorites: favorites));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void toggleFavorite(ProductModel product) {
    if (state is! ProductsLoaded) return;

    final currentState = state as ProductsLoaded;
    final updatedFavorites = List<ProductModel>.from(currentState.favorites);

    if (updatedFavorites.any((fav) => fav.id == product.id)) {
      updatedFavorites.remove(product);
      repo.removeFav(product.id);
    } else {
      updatedFavorites.add(product);
      repo.addFav(product.id);
    }

    emit(currentState.copyWith(favorites: updatedFavorites));
  }
}
