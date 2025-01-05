import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/dialog_helper.dart';
import '../../../../core/widgets/logout_dialog_widget.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../../../create_post/presentation/screens/create_post_screens.dart';
import '../../data/model/submit_react_req.dart';
import '../providers/feed_provider.dart';
import '../widgets/comment_bottomsheet.dart';
import '../widgets/feed_item_widget.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode myFocusNode = FocusNode();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedProvider.notifier).getFeeds();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        log("message");
        ref.read(feedProvider.notifier).loadMoreData();
        // if (SellerProductCategories.currentPage <= SellerProductCategories.lastPage) {
        //   ref.watch(productCategoriesProvider.notifier).getProductCategories();
        // } else {
        //   showToast(msg: 'No more data');
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedProvider);

    ref.listen<FeedState>(
      feedProvider,
      (FeedState? previous, FeedState next) {
        // for log out
        if (previous?.isLogOutLoading == false && next.isLogOutLoading == true) {
          DialogHelper.showLoading(context);
        }

        if (previous?.isLogOutLoading == true && next.isLogOutLoading == false) {
          DialogHelper.hideLoading(context);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (c) => const LoginScreen()), (route) => false);
          ref.read(feedProvider.notifier).resetState();
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        controller: scrollController,
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
                  ref.read(feedProvider.notifier).submitReact(
                        SubmitReactReq(
                          feedId: state.feeds[index].id,
                          action: "deleteOrCreate",
                          reactionSource: "COMMUNITY",
                          reactionType: text,
                        ),
                      );
                },
                commentsOnTap: (String text) async {
                  controller.clear();
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return CommentsBottomSheet(
                        data: state.feeds[index],
                        commentsController: controller,
                        commentsFocus: myFocusNode,
                      );
                    },
                  );
                  await ref.read(feedProvider.notifier).getComments(text, true);
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
