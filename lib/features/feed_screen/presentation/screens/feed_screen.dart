import 'package:ezycourse_community/core/utils/app_utils.dart';
import 'package:ezycourse_community/core/widgets/custom_network_image.dart';
import 'package:ezycourse_community/features/feed_screen/domain/entity/feed_data_entity.dart';

import '../../../../core/utils/color_manager.dart';
import '../providers/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedProvider.notifier).getFeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF115C67),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/svgs/menu.svg',
          ),
          onPressed: () {},
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Python Developer Community',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Gap(4),
            Text(
              '#General',
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/community_icom.svg'),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/logout_icon.svg'),
            label: 'Logout',
          ),
        ],
        selectedItemColor: ColorManager.primaryColor,
        selectedLabelStyle: const TextStyle(
          color: ColorManager.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xFF101828),
          fontWeight: FontWeight.w700,
          height: 1,
        ),
        onTap: (int index) {},
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF004852).withOpacity(.2),
              ),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/placeholder_img.png'),
                const Gap(12),
                const Text(
                  'Write Something here...',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF98A2B3),
                    fontSize: 17,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFF004852),
                  ),
                  child: const Text(
                    'Post',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Gap(16),
          ListView.builder(
            itemCount: state.feeds.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FeeItemWidget(
                data: state.feeds[index],
              );
            },
          )
        ],
      ),
    );
  }
}

class FeeItemWidget extends StatelessWidget {
  const FeeItemWidget({super.key, required this.data});

  final FeedDataEntity data;

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
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    AppUtils.displayTimeAgoFromTimestamp(data.createdAt.toString()),
                    textAlign: TextAlign.left,
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
        Text(
          data.feedTxt,
        ),
        const Gap(16),
        Image.asset('assets/images/demo_image.png'),
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
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                            child: Image.asset(dd.getStatusImg())),
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
            SvgPicture.asset('assets/svgs/comment.svg'),
            const Gap(8),
            Text(
              '${data.commentCount} Comments',
              style: const TextStyle(color: ColorManager.greyDarkColor, fontWeight: FontWeight.w700),
            )
          ],
        ),
        const Gap(16),
        Row(
          children: [
            Image.asset(
              'assets/images/like_fill.png',
              color: data.isUserReacted ? const Color(0xFF6662FF) : ColorManager.greyColor,
            ),
            const Gap(4),
            Expanded(
              child: Text(
                'Like',
                style: TextStyle(
                  color: data.isUserReacted ? const Color(0xFF6662FF) : ColorManager.greyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/comments_fill.png'),
            const Gap(4),
            const Text(
              'Comment',
              style: TextStyle(
                color: Color(0xFF1B1B35),
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const Gap(32)
      ],
    );
  }
}
