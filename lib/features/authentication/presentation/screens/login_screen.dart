import 'dart:developer';

import 'package:ezycourse_community/core/utils/app_utils.dart';
import 'package:ezycourse_community/features/feed_screen/presentation/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/password_text_field.dart';
import '../../../../core/widgets/primary_text_field.dart';
import '../../data/models/login_request.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const LoginTopSection(),
            Align(
              alignment: Alignment.bottomCenter,
              child: LoginBottomSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginTopSection extends StatelessWidget {
  const LoginTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(110),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Image.asset('assets/images/logo.png'),
        ),
      ],
    );
  }
}

class LoginBottomSection extends ConsumerWidget {
  LoginBottomSection({super.key});

  final TextEditingController emailController =
      TextEditingController(text: "soniamalik@gmail.com"); // TODO need to remove when release
  final TextEditingController passwordController = TextEditingController(text: "7654321");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    ref.listen<LoginState>(loginProvider, (LoginState? previous, LoginState next) {
      log("listen previousCount ${previous?.isSuccess} newCount ${next.isSuccess}");

      if (next.isSuccess) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => const FeedScreen()));
      }
    });
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF02363D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
          color: Color(0xFF125C67),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20),
              const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(20),
              PrimaryTextField(
                hint: "Email",
                label: "Email",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              const Gap(18),
              PasswordTextField(controller: passwordController),
              const Gap(16),
              Row(
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      side: const BorderSide(color: Colors.white),
                      value: state.isRemember,
                      onChanged: (val) {
                        ref.read(loginProvider.notifier).isRememberOnTap(val ?? false);
                      },
                      checkColor: Colors.black,
                      tristate: true,
                      activeColor: Colors.white,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'Remember me',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const Gap(32),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: ColorManager.btnColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        AppUtils.hideKeyboard();
                        LoginRequest request = LoginRequest(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            appToken: " ");
                        ref.read(loginProvider.notifier).login(request);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: ColorManager.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
