import 'package:ezycourse_community/core/utils/shared_preference_utils.dart';
import 'package:ezycourse_community/features/feed_screen/presentation/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/presentation/screens/login_screen.dart';

splashProvider(BuildContext context) => FutureProvider(
      (ref) async {
        await Future.delayed(const Duration(seconds: 2));

        if (SharedPrefUtil.instance.getIsRemember() && SharedPrefUtil.instance.getBearerToken() != "") {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FeedScreen()));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      },
    );
