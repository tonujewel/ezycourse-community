import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_constant.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/custom_toast.dart';
import '../../../../core/widgets/dialog_helper.dart';
import '../../../feed_screen/presentation/providers/feed_provider.dart';
import '../../data/data.dart';
import '../providers/create_post_providers.dart';

class CreatePostScreens extends ConsumerWidget {
  CreatePostScreens({super.key});

  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createPostProvider);

    ref.listen<CreatePostState>(createPostProvider, (CreatePostState? previous, CreatePostState next) {
      if (previous?.isLoading == false && next.isLoading == true) {
        DialogHelper.showLoading(context);
      }

      if (previous?.isLoading == true && next.isLoading == false) {
        DialogHelper.hideLoading(context);
        DialogHelper.hideLoading(context);
        ref.read(createPostProvider.notifier).resetState();
        ref.read(feedProvider.notifier).getFeeds();
      }
    });

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      appBar: AppBar(
        backgroundColor: ColorManager.bgColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Text(
            'Close',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(21, 25, 55, 1),
              fontFamily: 'Figtree',
            ),
          ),
        ),
        title: const Text(
          'Create Post',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Figtree',
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              if (postController.text.isEmpty) {
                CustomToast.errorToast(message: "Please write someting");
                return;
              }
              AppUtils.hideKeyboard();
              CreatePostReq req = CreatePostReq(
                feedTxt: postController.text,
                communityId: "2914",
                spaceId: "5883",
                uploadType: "text",
                activityType: "group",
                isBackground: state.selectedBg == 0 ? 0 : 1,
                bgColor:
                    state.selectedBg == 0 ? null : AppConstant.feedBackGroundGradientColors[(state.selectedBg - 1)],
              );
              log(req.toJson().toString());
              ref.read(createPostProvider.notifier).createPostApiCall(req);
              log(req.toJson().toString());
            },
            child: const Text(
              'Create',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(102, 98, 255, 1),
                fontFamily: 'Figtree',
                fontSize: 18,
              ),
            ),
          ),
          const Gap(16)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            width: 400,
            child: TextField(
              maxLines: 4,
              controller: postController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "What’s on your mind?",
                alignLabelWithHint: true,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
          const Gap(16),
          Row(
            children: List.generate(
              AppConstant.gradientsColor.length,
              (i) => InkWell(
                onTap: () {
                  ref.read(createPostProvider.notifier).gradiantOnSlect(i);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: AppConstant.gradientsColor[i],
                  ),
                  child: state.selectedBg == i ? const Icon(Icons.check) : const SizedBox(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
