import '../../domain/entities/login_entites.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.type, required super.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        type: json["type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
      };
}
