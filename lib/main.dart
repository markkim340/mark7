import 'package:flutter/material.dart';
import 'package:mark7/common/component/custom_text_form_field.dart';
import 'package:mark7/user/view/login_screen.dart';

void main() {
  runApp(_App());
}

/// Private class to avoid exposing the app's implementation details.
class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
