import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injector_container.dart';
import 'core/utils/color_manager.dart';
import 'features/splash/screen/splash_screen.dart';

SharedPreferences? preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await setupDI();

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
      home: const SplashScreen(),
    );
  }
}
