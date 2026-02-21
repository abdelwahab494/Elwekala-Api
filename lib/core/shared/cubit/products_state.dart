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
  final List<ProductModel> cart;

  ProductsLoaded({
    required this.products,
    required this.favorites,
    required this.cart,
  });

  ProductsLoaded copyWith({
    List<ProductModel>? products,
    List<ProductModel>? favorites,
    List<ProductModel>? cart,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      favorites: favorites ?? this.favorites,
      cart: cart ?? this.cart,
    );
  }
}
