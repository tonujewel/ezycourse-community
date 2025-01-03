import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String email;
  final String password;
  final String appToken;

  const LoginRequest({required this.email, required this.password, required this.appToken});

  @override
  List<Object?> get props => [email, password, appToken];

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "app_token": appToken,
      };
}
