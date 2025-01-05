import '../../domain/entities/logout_entity.dart';

class LogoutModel extends LogoutEntity {
  const LogoutModel({required super.msg});

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(msg: json["msg"]);
}
