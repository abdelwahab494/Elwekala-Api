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
      final List<ProductModel> cart = await repo.getCartProducts(
        "01055487878258",
      );
      emit(
        ProductsLoaded(products: products, favorites: favorites, cart: cart),
      );
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> loadCart() async {
    // If state is not ProductsLoaded, try to load everything first
    if (state is! ProductsLoaded) {
      // Load all products first to ensure we have a valid state
      await loadProducts();
      return;
    }

    try {
      final List<ProductModel> cart = await repo.getCartProducts(
        "01055487878258",
      );
      final currentState = state as ProductsLoaded;
      emit(currentState.copyWith(cart: cart));
    } catch (e) {
      // If cart loading fails, keep current state but set cart to empty
      if (state is ProductsLoaded) {
        final currentState = state as ProductsLoaded;
        emit(currentState.copyWith(cart: []));
      } else {
        emit(ProductsError(e.toString()));
      }
    }
  }

  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    if (state is! ProductsLoaded) return;

    try {
      await repo.addToCart("01055487878258", product.id, quantity);
      final List<ProductModel> cart = await repo.getCartProducts("01055487878258");
      final currentState = state as ProductsLoaded;
      emit(currentState.copyWith(cart: cart));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> removeFromCart(ProductModel product) async {
    if (state is! ProductsLoaded) return;

    try {
      await repo.removeFromCart("01055487878258", product.id);
      final List<ProductModel> cart = await repo.getCartProducts("01055487878258");
      final currentState = state as ProductsLoaded;
      emit(currentState.copyWith(cart: cart));
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
