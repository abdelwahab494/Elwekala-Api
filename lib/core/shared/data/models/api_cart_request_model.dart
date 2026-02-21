import 'package:products_api/core/shared/data/models/product_model.dart';

class ApiCartRequestModel {
  final String status;
  final List<ProductModel> cartProducts;

  ApiCartRequestModel({required this.status, required this.cartProducts});

  factory ApiCartRequestModel.fromJson(Map<String, dynamic> json) {
    final productsData = json["products"] ?? json["cartProducts"] ?? json["cart"] ?? [];
    return ApiCartRequestModel(
      status: json["status"] ?? "",
      cartProducts: productsData != null && productsData is List
          ? List<ProductModel>.from(
              productsData.map((x) => ProductModel.fromJson(x as Map<String, dynamic>)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "cartProducts": List<dynamic>.from(
      cartProducts.map((x) => x.toJson()),
    ),
  };
}
