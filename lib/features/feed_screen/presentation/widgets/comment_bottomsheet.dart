import 'dart:developer';

import 'package:ezycourse_community/features/feed_screen/data/model/ceare_reply_req.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/custom_toast.dart';
import '../../data/model/create_comments_req.dart';
import '../../domain/entity/comments_entity.dart';
import '../../domain/entity/feed_data_entity.dart';
import '../providers/feed_provider.dart';
import 'comments_item_widget.dart';

class CommentsBottomSheet extends ConsumerWidget {
  const CommentsBottomSheet({
    super.key,
    required this.data,
    required this.commentsController,
    required this.commentsFocus,
  });

  final FeedDataEntity data;

  final TextEditingController commentsController;
  final FocusNode commentsFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * .86,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    if (data.likeType.isNotEmpty)
                      Row(
                        children: data.likeType
                            .map(
                              (dd) => Align(
                                widthFactor: .7,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: Image.asset(
                                    dd.getStatusImg(),
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    if (data.likeType.isNotEmpty) const Gap(12),
                    Expanded(
                      child: Text(
                        data.isUserReacted == true ? 'You and ${data.likeCount} others' : '${data.likeCount} Likes',
                        style: const TextStyle(
                          color: ColorManager.greyDarkColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                state.isCommentsLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
                const Gap(16),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.commentsList.length,
                    itemBuilder: (context, index) {
                      return CommentsItemWidget(
                        data: state.commentsList[index],
                        replyOnTap: (CommentsEntity d) {
                          ref.read(feedProvider.notifier).replyOnTap(d);
                          // log("message${d.id}");
                          // commentsController.text = d.comments.userEntity.fullName;
                          commentsFocus.requestFocus();

                          log("message ${state.selectedComments?.id}");
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFF0F2F5),
                  ),
                  child: Column(
                    children: [
                      if (state.selectedComments != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              const Gap(8),
                              Row(
                                children: [
                                  const Text("Reply to "),
                                  Text(
                                    "${state.selectedComments?.userEntity.fullName}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(16),
                                  InkWell(
                                      onTap: () {
                                        log("message");
                                        ref.read(feedProvider.notifier).cancelReplyOnTap();
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const Gap(12),
                                  ClipOval(
                                    child: Image.asset(
                                      'assets/images/placeholder_img.png',
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Gap(4),
                                  Expanded(
                                    child: TextField(
                                      focusNode: commentsFocus,
                                      controller: commentsController,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        hintText: "Write here",
                                        hintStyle: TextStyle(
                                          color: Color(0xFF98A2B3),
                                          fontFamily: 'Figtree',
                                          fontSize: 16,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (commentsController.text.isEmpty) {
                                CustomToast.errorToast(message: "Please write comments");
                                return;
                              }

                              if (state.selectedComments == null) {
                                ref.read(feedProvider.notifier).createComments(
                                      CreateCommentsReq(
                                          feedId: data.id,
                                          feedUserId: data.userId,
                                          commentTxt: commentsController.text,
                                          commentSource: "COMMUNITY"),
                                    );

                                AppUtils.hideKeyboard();
                                commentsController.clear();
                              } else {
                                ref.read(feedProvider.notifier).createReply(
                                      CreateReplyReq(
                                        feedId: data.id,
                                        feedUserId: data.userId,
                                        commentTxt: commentsController.text,
                                        commentSource: "COMMUNITY",
                                        parrentId: state.selectedComments?.id ?? 0,
                                      ),
                                    );

                                AppUtils.hideKeyboard();
                                commentsController.clear();
                              }

                              log("message ${commentsController.text} ");
                            },
                            child: Container(
                              width: 60,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF004852),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Center(child: SvgPicture.asset('assets/svgs/sent.svg')),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
