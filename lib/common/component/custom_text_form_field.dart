import 'package:flutter/material.dart';
import 'package:mark7/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final String? initialValue;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      initialValue: initialValue,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
