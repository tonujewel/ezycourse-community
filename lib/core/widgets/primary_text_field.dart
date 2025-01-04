import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrimaryTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;

  const PrimaryTextField({
    super.key,
    required this.hint,
    this.controller,
    this.textInputType,
    this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF84AAB5)),
        ),
        const Gap(10),
        TextField(
          controller: controller,
          keyboardType: textInputType,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
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
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            fillColor: const Color(0xFF276871),
          ),
        ),
      ],
    );
  }
}
