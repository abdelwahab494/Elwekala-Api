import 'package:dio/dio.dart';
import 'package:products_api/core/shared/data/models/api_fav_request_model.dart';
import 'package:products_api/core/shared/data/models/api_request_model.dart';
import 'package:products_api/core/shared/data/models/auth_model.dart';
import 'package:products_api/core/shared/data/models/product_model.dart';

class ApiRepo {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://elwekala.onrender.com"));

  Future<List<ProductModel>> loadProductsData() async {
    final Response response = await dio.get("/product/Laptops");
    final Map<String, dynamic> data =
        response.data as Map<String, dynamic>? ?? {};
    final ApiRequestModel mainModel = ApiRequestModel.fromJson(data);
    return mainModel.product;
  }

  Future<List<ProductModel>> getFavProducts() async {
    final response = await dio.get(
      "/favorite",
      queryParameters: {"nationalId": "01055487878258"},
    );

    final data = response.data as Map<String, dynamic>? ?? {};
    final mainModel = ApiFavRequestModel.fromJson(data);
    return mainModel.favoriteProducts;
  }

  Future<String> addFav(String id) async {
    final Response response = await dio.post(
      "/favorite",
      data: {"nationalId": "01055487878258", "productId": id},
    );
    final data = response.data as Map<String, dynamic>? ?? {};
    return data["message"] ?? "";
  }

  Future<String> removeFav(String id) async {
    final Response response = await dio.delete(
      "/favorite",
      data: {"nationalId": "01055487878258", "productId": id},
    );
    final data = response.data as Map<String, dynamic>? ?? {};
    return data["message"] ?? "";
  }

  Future<List<ProductModel>> getCartProducts(String nationalId) async {
    try {
      final Response response = await dio.get(
        "/cart/allProducts",
        data: {"nationalId": nationalId},
      );
      final List<dynamic> data = response.data["products"];
      final List<ProductModel> cartList = data
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return cartList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> addToCart(
    String nationalId,
    String productId,
    int quantity,
  ) async {
    print(productId);
    try {
      final Response response = await dio.post(
        "/cart/add",
        data: {
          "nationalId": nationalId,
          "productId": productId,
          "quantity": quantity,
        },
      );
      final data = response.data as Map<String, dynamic>? ?? {};
      return data["message"] ?? "Product added to cart";
    } on DioException catch (e) {
      String errorMessage = "Failed to add product to cart";
      if (e.response != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data["message"] ?? errorMessage;
        }
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("Failed to add product to cart: ${e.toString()}");
    }
  }

  Future<String> removeFromCart(String nationalId, String productId) async {
    try {
      final Response response = await dio.delete(
        "/cart/delete",
        data: {"nationalId": nationalId, "productId": productId},
      );
      final data = response.data;
      if (data is Map) {
        return data["message"];
      }
      return "Product removed from cart";
    } on DioException catch (e) {
      String errorMessage = "Failed to remove product from cart";
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          return "Product removed from cart";
        }
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data["message"] ?? errorMessage;
        }
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("Failed to remove product from cart: ${e.toString()}");
    }
  }

  Future<AuthModel> login(String email, String password) async {
    try {
      final Response response = await dio.post(
        "/user/login",
        data: {"email": email, "password": password},
      );
      final Map<String, dynamic> data =
          response.data as Map<String, dynamic>? ?? {};
      final AuthModel model = AuthModel.fromJson(data);

      if (model.status != "success") {
        throw Exception(model.message);
      }
      return model;
    } on DioException catch (e) {
      String errorMessage = "Unexpected Error Ocured!";
      if (e.response != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data["message"] ?? errorMessage;
        }
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AuthModel> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String nationalId,
    required String gender,
    required String image,
  }) async {
    try {
      final Response response = await dio.post(
        "/user/register",
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "nationalId": nationalId,
          "gender": gender,
          "profileImage": image,
        },
      );
      final Map<String, dynamic> data =
          response.data as Map<String, dynamic>? ?? {};
      final AuthModel model = AuthModel.fromJson(data);

      if (model.status != "success") {
        throw Exception(model.message);
      }
      return model;
    } on DioException catch (e) {
      String errorMessage = "Unexpected Error Ocured!";
      if (e.response != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data["message"] ?? errorMessage;
        }
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
