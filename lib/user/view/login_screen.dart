import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/common/component/custom_text_form_field.dart';
import 'package:mark7/common/const/colors.dart';
import 'package:mark7/common/layout/default_layout.dart';
import 'package:mark7/user/model/user_model.dart';
import 'package:mark7/user/provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = 'test@codefactory.ai';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);

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
                  initialValue: username,
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Enter your password',
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          ref
                              .read(userMeProvider.notifier)
                              .login(username: username, password: password);
                        },
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
                  child: Text(
                    "sign up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR,
                    ),
                  ),
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
