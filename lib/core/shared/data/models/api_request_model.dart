import 'package:products_api/core/shared/data/models/product_model.dart';

class ApiRequestModel {
    final String status;
    final String message;
    final List<ProductModel> product;

    ApiRequestModel({
        required this.status,
        required this.message,
        required this.product,
    });

    factory ApiRequestModel.fromJson(Map<String, dynamic> json) => ApiRequestModel(
        status: json["status"],
        message: json["message"],
        product: List<ProductModel>.from(json["product"].map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
    };
}
