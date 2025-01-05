import 'dart:developer';

import 'package:ezycourse_community/features/feed_screen/data/model/ceare_reply_req.dart';
import 'package:ezycourse_community/features/feed_screen/domain/usecases/create_reply_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/custom_toast.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../../../authentication/authentication.dart';
import '../../data/model/create_comments_req.dart';
import '../../data/model/submit_react_req.dart';
import '../../domain/entity/comments_entity.dart';
import '../../domain/entity/comments_with_reply_entity.dart';
import '../../domain/entity/feed_data_entity.dart';
import '../../domain/entity/reply_entity.dart';
import '../../domain/usecases/create_comments_usecases.dart';
import '../../domain/usecases/get_comments_usecases.dart';
import '../../domain/usecases/get_feed_usecases.dart';
import '../../domain/usecases/get_replies_usecases.dart';
import '../../domain/usecases/submit_reac_usecases.dart';

class FeedState {
  final bool isLogOutLoading;
  final bool isLoading;
  final bool isCommentsLoading;
  final bool isSuccess;
  final String? error;
  final CommentsEntity? selectedComments;
  final List<FeedDataEntity> feeds;
  final List<CommentsWithReplyEntity> commentsList;

  FeedState({
    this.isLogOutLoading = false,
    this.isLoading = false,
    this.isCommentsLoading = false,
    this.isSuccess = false,
    this.error,
    this.selectedComments,
    required this.feeds,
    required this.commentsList,
  });

  FeedState copyWith({
    bool? isLogOutLoading,
    bool? isLoading,
    bool? isCommentsLoading,
    bool? isSuccess,
    String? error,
    CommentsEntity? selectedComments,
    bool? isRemember,
    List<FeedDataEntity>? feeds,
    List<CommentsWithReplyEntity>? commentsList,
  }) {
    return FeedState(
      isLogOutLoading: isLogOutLoading ?? this.isLogOutLoading,
      isLoading: isLoading ?? this.isLoading,
      isCommentsLoading: isCommentsLoading ?? this.isCommentsLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      selectedComments: selectedComments,
      feeds: feeds ?? this.feeds,
      commentsList: commentsList ?? this.commentsList,
    );
  }
}

class FeedNotifier extends StateNotifier<FeedState> {
  final GetFeedUsecases feedUsecases;
  final LogoutUsecases logoutUsecases;
  final SubmitReacUsecases submitReacUsecases;
  final GetCommentsUsecases getCommentsUsecases;
  final GetRepliesUsecases getRepliesUsecases;
  final CreateCommentsUsecases createCommentsUseCase;
  final CreateReplyUsecases createReplyUsecases;

  FeedNotifier(this.feedUsecases, this.logoutUsecases, this.submitReacUsecases, this.getCommentsUsecases,
      this.getRepliesUsecases, this.createCommentsUseCase, this.createReplyUsecases)
      : super(FeedState(feeds: [], commentsList: []));

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
        await getFeeds();
      },
    );
  }

  Future<void> createComments(CreateCommentsReq req) async {
    final response = await createCommentsUseCase.call(req);

    state = state.copyWith(isCommentsLoading: true);

    response.fold(
      (l) {
        CustomToast.errorToast(message: l.message);
        state = state.copyWith(isCommentsLoading: false);
      },
      (r) async {
        await getComments(req.feedId.toString(), false);
        getFeeds();
        // state = state.copyWith(isCommentsLoading: false);
      },
    );
  }

  Future<void> createReply(CreateReplyReq req) async {
    final response = await createReplyUsecases.call(req);

    state = state.copyWith(isCommentsLoading: true);

    response.fold(
      (l) {
        CustomToast.errorToast(message: l.message);
        state = state.copyWith(isCommentsLoading: false);
      },
      (r) async {
        await getComments(req.feedId.toString(), false);
        getFeeds();
        // state = state.copyWith(isCommentsLoading: false);
      },
    );
  }

  Future<void> getComments(String id, bool isResetList) async {
    if (isResetList) {
      state = state.copyWith(commentsList: []);
    }
    state = state.copyWith(isCommentsLoading: true);

    final response = await getCommentsUsecases.call(id);

    response.fold(
      (l) {
        state = state.copyWith(isLogOutLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
        state = state.copyWith(isCommentsLoading: false);
      },
      (r) async {
        List<CommentsWithReplyEntity> listData = [];

        for (var data in r) {
          List<ReplyDataEntity> repliesList = await getReplise(data.id.toString());

          log("repliesList ${repliesList.length}");

          listData.add(
            CommentsWithReplyEntity(comments: data, replies: List.from(repliesList)),
          );
        }

        log("listData ${listData.length}");
        state = state.copyWith(isCommentsLoading: false, commentsList: List.from(listData));
      },
    );
  }

  Future<List<ReplyDataEntity>> getReplise(String id) async {
    final response = await getRepliesUsecases.call(id);

    List<ReplyDataEntity> listData = [];

    response.fold(
      (l) {
        state = state.copyWith(isLogOutLoading: false, isSuccess: false, error: l.message);
        CustomToast.errorToast(message: l.message);
      },
      (r) async {
        listData = List.from(r);
      },
    );
    return listData;
  }

  void replyOnTap(CommentsEntity data) {
    state = state.copyWith(selectedComments: data);
  }

  void cancelReplyOnTap() {
    state = state.copyWith(selectedComments: null);
  }

  void resetState() {
    state = FeedState(feeds: [], commentsList: []);
  }
}

final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  final feedUsecase = ref.watch(feedUsecaseProvider);
  final logoutUsecase = ref.watch(logoutUseCaseProvider);
  final submitReactUseCase = ref.watch(submitReactUseCaseProvider);
  final getCommentsUseCase = ref.watch(getCommentsUseCaseProvider);
  final getRepliesUseCase = ref.watch(getRepliesUseCaseProvider);
  final createCommentsUseCase = ref.watch(createCommentsUseCaseProvider);
  final createReplyUseCase = ref.watch(createReplyUseCaseProvider);
  return FeedNotifier(feedUsecase, logoutUsecase, submitReactUseCase, getCommentsUseCase, getRepliesUseCase,
      createCommentsUseCase, createReplyUseCase);
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

final getCommentsUseCaseProvider = Provider<GetCommentsUsecases>((ref) {
  return GetIt.instance<GetCommentsUsecases>();
});

final getRepliesUseCaseProvider = Provider<GetRepliesUsecases>((ref) {
  return GetIt.instance<GetRepliesUsecases>();
});
final createCommentsUseCaseProvider = Provider<CreateCommentsUsecases>((ref) {
  return GetIt.instance<CreateCommentsUsecases>();
});
final createReplyUseCaseProvider = Provider<CreateReplyUsecases>((ref) {
  return GetIt.instance<CreateReplyUsecases>();
});
