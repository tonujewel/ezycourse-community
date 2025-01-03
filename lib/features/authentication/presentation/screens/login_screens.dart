import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/password_text_field.dart';
import '../../../../core/widgets/primary_text_field.dart';

class LoginScreens extends ConsumerWidget {
  const LoginScreens({super.key});

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
        child: const Stack(
          children: [
            LoginTopSection(),
            Align(alignment: Alignment.bottomCenter, child: LoginBottomSection()),
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

class LoginBottomSection extends StatelessWidget {
  const LoginBottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Figtree',
                  fontSize: 30,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(20),
              const PrimaryTextField(hint: "Email", label: "Email"),
              const Gap(18),
              const PasswordTextField(),
              const Gap(16),
              Row(
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      side: const BorderSide(color: Colors.white),
                      value: true,
                      onChanged: (val) {},
                      checkColor: Colors.black,
                      fillColor: WidgetStateProperty.all(Colors.white),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: ColorManager.btnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
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
