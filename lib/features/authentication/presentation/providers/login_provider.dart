import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../data/models/login_request.dart';
import '../../domain/usecases/login_usecases.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  LoginState({this.isLoading = false, this.isSuccess = false, this.error});

  LoginState copyWith({bool? isLoading, bool? isSuccess, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUsecases loginUseCase;

  LoginNotifier(this.loginUseCase) : super(LoginState());

  Future<void> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true);
    // try {
    final response = await loginUseCase.call(request);
    response.fold(
      (l) {
        log("message ${l.message} ${l.statusCode}");
        state = state.copyWith(isLoading: false, isSuccess: false, error: l.message);
      },
      (r) {
        log("message ${r.token}");

        state = state.copyWith(isLoading: false, isSuccess: true);
      },
    );
    // } catch (e) {
    //   state = state.copyWith(isLoading: false, error: e.toString());
    // }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return LoginNotifier(loginUseCase);
});

final loginUseCaseProvider = Provider<LoginUsecases>((ref) {
  return GetIt.instance<LoginUsecases>();
});
