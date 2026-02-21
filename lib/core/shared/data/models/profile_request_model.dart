class ProfileRequestModel {
  final String status;
  final dynamic message;
  final ProfileModel user;

  ProfileRequestModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory ProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      ProfileRequestModel(
        status: json["status"],
        message: json["message"],
        user: ProfileModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user.toJson(),
  };
}

class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String gender;
  final String profileImage;
  final String token;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.gender,
    required this.profileImage,
    required this.token,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    nationalId: json["nationalId"],
    gender: json["gender"],
    profileImage: json["profileImage"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "nationalId": nationalId,
    "gender": gender,
    "profileImage": profileImage,
    "token": token,
  };
}
