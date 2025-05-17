import 'package:flutter/material.dart';
import 'package:mark7/common/component/custom_text_form_field.dart';
import 'package:mark7/common/const/colors.dart';
import 'package:mark7/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const _SubTitle(),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.asset(
                    "asset/img/misc/ai_logo.png",
                    height: MediaQuery.of(context).size.width / 1,
                  ),
                ),
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: PRIMARY_COLOR,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Welcome!",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Use your email to login\nInvite to the AI world',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: BODY_TEXT_COLOR,
        ));
  }
}
