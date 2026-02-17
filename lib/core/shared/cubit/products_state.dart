import 'package:products_api/core/shared/data/models/product_model.dart';

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final List<ProductModel> favorites;

  ProductsLoaded({
    required this.products,
    required this.favorites,
  });

  ProductsLoaded copyWith({
    List<ProductModel>? products,
    List<ProductModel>? favorites,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      favorites: favorites ?? this.favorites,
    );
  }
}
