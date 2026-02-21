import 'package:products_api/core/shared/data/models/user_model.dart';

class AuthModel {
  final String status;
  final String message;
  final UserModel? user;

  AuthModel({required this.status, required this.message, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    status: json["status"],
    message: json["message"],
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user?.toJson(),
  };
}
