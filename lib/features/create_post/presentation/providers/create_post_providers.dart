import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/custom_toast.dart';
import '../../data/model/crate_post_req.dart';
import '../../domain/usecases/create_post_usecases.dart';

class CreatePostState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final int selectedBg;

  CreatePostState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.selectedBg = 0,
  });

  CreatePostState copyWith({bool? isLoading, String? error, bool? isSuccess, int? selectedBg}) {
    return CreatePostState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      selectedBg: selectedBg ?? this.selectedBg,
    );
  }
}

class CreatePostNotifier extends StateNotifier<CreatePostState> {
  final CreatePostUsecases createPostUsecases;

  CreatePostNotifier(this.createPostUsecases) : super(CreatePostState());

  Future<void> createPostApiCall(CreatePostReq req) async {
    log("creating post");

    state = state.copyWith(isLoading: true);
    final response = await createPostUsecases.call(req);

    response.fold(
      (l) {
        state = state.copyWith(isLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSuccess: true);
        CustomToast.successToast(message: "Post successfully created");
      },
    );
  }

  void gradiantOnSlect(int index) {
    if (index == state.selectedBg) {
      state = state.copyWith(selectedBg: 0);
    } else {
      state = state.copyWith(selectedBg: index);
    }
  }

  void resetState() {
    state = CreatePostState();
  }
}

final createPostProvider = StateNotifierProvider<CreatePostNotifier, CreatePostState>((ref) {
  final createPostUsecase = ref.watch(createPostUsecaseUsecaseProvider);

  return CreatePostNotifier(createPostUsecase);
});

final createPostUsecaseUsecaseProvider = Provider<CreatePostUsecases>((ref) {
  return GetIt.instance<CreatePostUsecases>();
});
