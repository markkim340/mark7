import 'package:flutter/material.dart';
import 'package:mark7/common/component/custom_text_form_field.dart';
import 'package:mark7/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Title(),
          CustomTextFormField(
            hintText: 'Enter your email',
            onChanged: (String value) {},
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter your password',
            obscureText: true,
            onChanged: (String value) {},
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("환영합니다.");
  }
}
