import 'dart:developer';

import 'package:ezycourse_community/features/create_post/presentation/screens/create_post_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_constant.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/dialog_helper.dart';
import '../../../../core/widgets/logout_dialog_widget.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../../data/model/submit_react_req.dart';
import '../../domain/entity/feed_data_entity.dart';
import '../providers/feed_provider.dart';

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

    ref.listen<FeedState>(feedProvider, (FeedState? previous, FeedState next) {
      log("${previous?.isLogOutLoading}  ${next.isLogOutLoading == true}");

      if (previous?.isLogOutLoading == false && next.isLogOutLoading == true) {
        DialogHelper.showLoading(context);
      }

      if (previous?.isLogOutLoading == true && next.isLogOutLoading == false) {
        DialogHelper.hideLoading(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const LoginScreen()),
          (route) => false,
        );

        ref.read(feedProvider.notifier).resetState();
      }
    });

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
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
        ),
        onTap: (int index) {
          if (index == 1) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return LogoutDialogWidget(
                  yesOnTap: () {
                    ref.read(feedProvider.notifier).doLogout();
                  },
                );
              },
            );
          }
        },
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
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => CreatePostScreens()));
              },
              child: Row(
                children: [
                  Image.asset('assets/images/placeholder_img.png'),
                  const Gap(12),
                  const Text(
                    'Write Something here...',
                    style: TextStyle(
                      color: Color(0xFF98A2B3),
                      fontSize: 16,
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
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Gap(16),
          ListView.builder(
            itemCount: state.feeds.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FeedItemWidget(
                data: state.feeds[index],
                onReactTap: (String text) {
                  //

                  SubmitReactReq req = SubmitReactReq(
                    feedId: state.feeds[index].id,
                    action: "deleteOrCreate",
                    reactionSource: "COMMUNITY",
                    reactionType: text,
                  );

                  ref.read(feedProvider.notifier).submitReact(req);
                },
              );
            },
          ),
          state.isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox()
        ],
      ),
    );
  }
}

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget({super.key, required this.data, required this.onReactTap});

  final FeedDataEntity data;

  final Function(String text) onReactTap;

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
            SizedBox.square(
              dimension: 30,
              child: ReactionButton(
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
                child: Image.asset('assets/images/like_fill.png'),
              ),
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
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const CommentsBottomSheet();
                  },
                );
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

class CommentsBottomSheet extends StatelessWidget {
  const CommentsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      height: MediaQuery.of(context).size.height * .8,
      child: Column(
        children: [
          const Row(
            children: [Text("You and 2 other")],
          ),
          const Gap(16),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const CommentsItemWidget();
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFFF0F2F5),
            ),
            child: Row(
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
                        const Gap(12),
                        const Text(
                          'Write a Comment',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF98A2B3),
                            fontFamily: 'Figtree',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CommentsItemWidget extends StatelessWidget {
  const CommentsItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/placeholder_img.png',
              fit: BoxFit.cover,
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
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IAP Testing',
                              style: TextStyle(fontFamily: 'Figtree', fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '4 cup tcake',
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.more_horiz_outlined)
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
                    const Text("Reply"),
                    const Gap(8),
                    const Spacer(),
                    const Text(
                      "1",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Image.asset('assets/images/like.png')
                  ],
                ),
                const Gap(12),
                ListView.builder(
                    itemCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const ReplyItemWidget();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReplyItemWidget extends StatelessWidget {
  const ReplyItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/placeholder_img.png',
              height: 40,
              width: 40,
              fit: BoxFit.cover,
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
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IAP Testing',
                              style: TextStyle(fontFamily: 'Figtree', fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '4 cup tcake',
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.more_horiz_outlined)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
