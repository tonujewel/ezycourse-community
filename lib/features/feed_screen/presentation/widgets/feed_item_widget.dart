import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_constant.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../domain/entity/feed_data_entity.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget({super.key, required this.data, required this.onReactTap, required this.commentsOnTap});

  final FeedDataEntity data;

  final Function(String text) onReactTap;
  final Function(String text) commentsOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomNetworkImage(
              imageUrl: data.pic,
              height: 36,
              width: 36,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    AppUtils.displayTimeAgoFromTimestamp(data.createdAt.toString()),
                    style: const TextStyle(
                      color: ColorManager.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.more_vert_outlined,
              size: 25,
              color: Color(0xFF5F6368),
            ),
          ],
        ),
        const Divider(),
        const Gap(8),
        data.isBackground == 1
            ? Container(
                constraints: const BoxConstraints(minHeight: 160, minWidth: double.infinity),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: AppUtils.getGradiant(data.bgColor ?? ""),
                ),
                child: Center(
                  child: Text(
                    data.feedTxt,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Text(data.feedTxt),
        const Gap(16),
        if (data.getSingleFile() != null && data.fileType == "photos")
          CustomNetworkImage(
            width: double.infinity,
            borderRadius: 10,
            imageUrl: data.getSingleFile()?.fileLoc ?? "",
            fit: BoxFit.cover,
          ),
        const Gap(12),
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
            InkWell(
              onTap: () => commentsOnTap("${data.id}"),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svgs/comment.svg'),
                  const Gap(8),
                  Text(
                    '${data.commentCount} Comments',
                    style: const TextStyle(color: ColorManager.greyDarkColor, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReactionButton(
              toggle: false,
              direction: ReactionsBoxAlignment.ltr,
              onReactionChanged: (Reaction<String>? reaction) {
                onReactTap(reaction?.value ?? "");
              },
              reactions: AppConstant.reactionList,
              boxColor: Colors.white,
              boxRadius: 30,
              itemsSpacing: 16,
              itemSize: const Size(40, 40),
              boxPadding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Image.asset('assets/images/like_fill.png'),
                  const Gap(8),
                  Text(
                    'Like',
                    style: TextStyle(
                      color: data.isUserReacted ? const Color(0xFF6662FF) : ColorManager.greyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const Gap(8),
            InkWell(
              onTap: () {
                commentsOnTap("${data.id}");
              },
              child: Row(
                children: [
                  Image.asset('assets/images/comments_fill.png'),
                  const Gap(4),
                  const Text(
                    'Comment',
                    style: TextStyle(
                      color: Color(0xFF1B1B35),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const Gap(32)
      ],
    );
  }
}
