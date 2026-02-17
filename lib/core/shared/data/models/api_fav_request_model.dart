import 'package:products_api/core/shared/data/models/product_model.dart';

class ApiFavRequestModel {
  final String status;
  final List<ProductModel> favoriteProducts;

  ApiFavRequestModel({required this.status, required this.favoriteProducts});

  factory ApiFavRequestModel.fromJson(Map<String, dynamic> json) =>
      ApiFavRequestModel(
        status: json["status"],
        favoriteProducts: List<ProductModel>.from(
          json["favoriteProducts"].map((x) => ProductModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "favoriteProducts": List<dynamic>.from(
      favoriteProducts.map((x) => x.toJson()),
    ),
  };
}