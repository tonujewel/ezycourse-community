import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/custom_toast.dart';
import '../../domain/entity/feed_data_entity.dart';
import '../../domain/usecases/get_feed_usecases.dart';

class FeedState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<FeedDataEntity> feeds;

  FeedState({this.isLoading = false, this.isSuccess = false, this.error, required this.feeds});

  FeedState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    bool? isRemember,
    List<FeedDataEntity>? feeds,
  }) {
    return FeedState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      feeds: feeds ?? this.feeds,
    );
  }
}

class FeedNotifier extends StateNotifier<FeedState> {
  final GetFeedUsecases feedUsecases;
  FeedNotifier(this.feedUsecases) : super(FeedState(feeds: []));

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
}

final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  final feedUsecase = ref.watch(feedUsecaseProvider);
  return FeedNotifier(feedUsecase);
});

final feedUsecaseProvider = Provider<GetFeedUsecases>((ref) {
  return GetIt.instance<GetFeedUsecases>();
});
