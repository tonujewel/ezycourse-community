import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/custom_toast.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../../../authentication/authentication.dart';
import '../../data/model/submit_react_req.dart';
import '../../domain/entity/feed_data_entity.dart';
import '../../domain/usecases/get_feed_usecases.dart';
import '../../domain/usecases/submit_reac_usecases.dart';

class FeedState {
  final bool isLogOutLoading;
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<FeedDataEntity> feeds;

  FeedState({
    this.isLogOutLoading = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    required this.feeds,
  });

  FeedState copyWith({
    bool? isLogOutLoading,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    bool? isRemember,
    List<FeedDataEntity>? feeds,
  }) {
    return FeedState(
      isLogOutLoading: isLogOutLoading ?? this.isLogOutLoading,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      feeds: feeds ?? this.feeds,
    );
  }
}

class FeedNotifier extends StateNotifier<FeedState> {
  final GetFeedUsecases feedUsecases;
  final LogoutUsecases logoutUsecases;
  final SubmitReacUsecases submitReacUsecases;
  FeedNotifier(this.feedUsecases, this.logoutUsecases, this.submitReacUsecases) : super(FeedState(feeds: []));

  Future<void> getFeeds() async {
    log("fetching data");
    state = state.copyWith(isLoading: true);
    final response = await feedUsecases.call();

    response.fold(
      (l) {
        state = state.copyWith(isLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSuccess: true, feeds: r);
      },
    );
  }

  Future<void> doLogout() async {
    state = state.copyWith(isLogOutLoading: true);
    final response = await logoutUsecases.call();

    response.fold(
      (l) {
        state = state.copyWith(isLogOutLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
      },
      (r) async {
        CustomToast.successToast(message: r.msg);
        await SharedPrefUtil.clear();
        state = state.copyWith(isLogOutLoading: false);
      },
    );
  }

  Future<void> submitReact(SubmitReactReq req) async {
    final response = await submitReacUsecases.call(req);

    response.fold(
      (l) {
        state = state.copyWith(isLogOutLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
      },
      (r) async {
        // CustomToast.successToast(message: r.msg);
        // await SharedPrefUtil.clear();
        // state = state.copyWith(isLogOutLoading: false);
        log("sucess");
        await getFeeds();
      },
    );
  }

  void resetState() {
    state = FeedState(feeds: []);
  }
}

final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  final feedUsecase = ref.watch(feedUsecaseProvider);
  final logoutUsecase = ref.watch(logoutUseCaseProvider);
  final submitReactUseCase = ref.watch(submitReactUseCaseProvider);
  return FeedNotifier(feedUsecase, logoutUsecase, submitReactUseCase);
});

final feedUsecaseProvider = Provider<GetFeedUsecases>((ref) {
  return GetIt.instance<GetFeedUsecases>();
});

final logoutUseCaseProvider = Provider<LogoutUsecases>((ref) {
  return GetIt.instance<LogoutUsecases>();
});

final submitReactUseCaseProvider = Provider<SubmitReacUsecases>((ref) {
  return GetIt.instance<SubmitReacUsecases>();
});
