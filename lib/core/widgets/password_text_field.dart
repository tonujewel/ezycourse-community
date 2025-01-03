import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hints;

  const PasswordTextField({
    super.key,
    this.controller,
    this.textInputType,
    this.hints,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          textAlign: TextAlign.left,
          style: TextStyle(color: Color(0xFF84AAB5)),
        ),
        const Gap(10),
        TextField(
          obscureText: hidePassword,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hints ?? "Password",
            suffixIcon: IconButton(
              icon: hidePassword ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 1, color: const Color(0xFFD0D5DD).withOpacity(.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 1, color: const Color(0xFFD0D5DD).withOpacity(.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 1, color: const Color(0xFFD0D5DD).withOpacity(.2)),
            ),
            filled: true,
            hintStyle: const TextStyle(color: Colors.white),
            fillColor: const Color(0xFF276871),
          ),
        ),
      ],
    );
  }
}
