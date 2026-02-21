class UserModel {
    final String name;
    final String email;
    final String phone;
    final String nationalId;
    final String gender;
    final String profileImage;
    final String token;

    UserModel({
        required this.name,
        required this.email,
        required this.phone,
        required this.nationalId,
        required this.gender,
        required this.profileImage,
        required this.token,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
