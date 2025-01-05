import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../domain/entity/comments_entity.dart';
import '../../domain/entity/comments_with_reply_entity.dart';
import 'reply_item_widget.dart';

class CommentsItemWidget extends StatelessWidget {
  const CommentsItemWidget({super.key, required this.data, required this.replyOnTap});

  final CommentsWithReplyEntity data;
  final Function(CommentsEntity data) replyOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CustomNetworkImage(
              imageUrl: data.comments.userEntity.profilePic,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.comments.userEntity.fullName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              data.comments.commentTxt,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_horiz_outlined)
                    ],
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    const Gap(16),
                    const Text(
                      "Like",
                      style: TextStyle(color: Color(0xFF6662FF)),
                    ),
                    const Gap(16),
                    InkWell(
                        onTap: () {
                          replyOnTap(data.comments);
                        },
                        child: const Text("Reply")),
                    const Gap(8),
                    const Spacer(),
                    Text(
                      "${data.comments.likeCount}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Image.asset('assets/images/like.png')
                  ],
                ),
                const Gap(12),
                ListView.builder(
                  itemCount: data.replies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ReplyItemWidget(data: data.replies[index]);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
