import 'package:ezycourse_community/core/utils/app_utils.dart';
import 'package:ezycourse_community/features/authentication/presentation/screens/login_screen.dart';
import 'package:ezycourse_community/features/feed_screen/presentation/screens/feed_screen.dart';

import 'core/utils/color_manager.dart';
import 'core/utils/shared_preference_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/injector_container.dart';
import 'features/splash/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtil.instance.init();
  await init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ezycourse Community',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primaryColor),
        useMaterial3: true,
      ),
      home: AppUtils.isNavigateToFeed() ? const FeedScreen() : const SplashScreen(),
    );
  }
}
