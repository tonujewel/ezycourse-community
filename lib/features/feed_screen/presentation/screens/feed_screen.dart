import 'package:ezycourse_community/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const Center(
              child: Text("Home Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
