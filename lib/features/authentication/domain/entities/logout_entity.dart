import 'package:equatable/equatable.dart';

class LogoutEntity extends Equatable {
  final String msg;

  const LogoutEntity({required this.msg});

  @override
  List<Object?> get props => [msg];
}
