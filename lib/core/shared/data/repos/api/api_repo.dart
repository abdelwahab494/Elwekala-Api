import 'package:dio/dio.dart';
import 'package:products_api/core/shared/data/models/api_fav_request_model.dart';
import 'package:products_api/core/shared/data/models/api_request_model.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';

class ApiRepo {
  final Dio dio = Dio();

  Future<List<ProductModel>> loadProductsData() async {
    final Response response = await dio.get(
      "https://elwekala.onrender.com/product/Laptops",
    );
    final Map<String, dynamic> data = response.data;
    final ApiRequestModel mainModel = ApiRequestModel.fromJson(data);
    return mainModel.product;
  }

  Future<List<ProductModel>> getFavProducts() async {
    final Response response = await dio.get(
      "https://elwekala.onrender.com/favorite",
      data: {"nationalId": "01055487878258"},
    );
    final Map<String, dynamic> data = response.data;
    final ApiFavRequestModel mainModel = ApiFavRequestModel.fromJson(data);
    return mainModel.favoriteProducts;
  }

  Future<String> addFav(String id) async {
    final Response response = await dio.post(
      "https://elwekala.onrender.com/favorite",
      data: {"nationalId": "01055487878258", "productId": id},
    );
    print(id);
    return response.data["message"];
  }

  Future<String> removeFav(String id) async {
    final Response response = await dio.delete(
      "https://elwekala.onrender.com/favorite",
      data: {"nationalId": "01055487878258", "productId": id},
    );
    print(id);
    return response.data["message"];
  }
}
