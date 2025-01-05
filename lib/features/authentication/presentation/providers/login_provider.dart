import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/custom_toast.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../../data/models/login_request.dart';
import '../../domain/usecases/login_usecases.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isRemember;
  final String? error;

  LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.isRemember = true,
  });

  LoginState copyWith({bool? isLoading, bool? isSuccess, String? error, bool? isRemember}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      isRemember: isRemember ?? this.isRemember,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUsecases loginUseCase;

  LoginNotifier(this.loginUseCase) : super(LoginState());

  Future<void> login(LoginRequest request) async {
    if (!loginValidation(request)) {
      return;
    }

    state = state.copyWith(isLoading: true);
    final response = await loginUseCase.call(request);
    response.fold(
      (l) {
        state = state.copyWith(isLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
      },
      (r) async {
        CustomToast.successToast(message: "Login Success");

        // await Future.delayed(const Duration(seconds: 30));

        await SharedPrefUtil.storeIsRemember(state.isRemember);
        await SharedPrefUtil.storeBearerToken(r.token);

        // getIt.unregister<DioClient>();
        // getIt.registerLazySingleton(() => DioClient());

        state = state.copyWith(isLoading: false, isSuccess: true);
      },
    );
  }

  void resetState() {
    state = LoginState();
  }

  bool loginValidation(LoginRequest request) {
    if (request.email.isEmpty) {
      CustomToast.errorToast(message: "Email required");
      return false;
    }
    if (!AppUtils.validateEmail(request.email)) {
      CustomToast.errorToast(message: "Invalid Email required");
      return false;
    }

    if (request.password.isEmpty) {
      CustomToast.errorToast(message: "Password required");
      return false;
    }

    return true;
  }

  void isRememberOnTap(bool value) {
    state = state.copyWith(isRemember: value);
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return LoginNotifier(loginUseCase);
});

final loginUseCaseProvider = Provider<LoginUsecases>((ref) {
  return GetIt.instance<LoginUsecases>();
});
