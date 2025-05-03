import 'package:flutter/material.dart';
import 'package:mark7/common/component/custom_text_form_field.dart';

void main() {
  runApp(_App());
}

/// Private class to avoid exposing the app's implementation details.
class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: 'Enter your email',
              onChanged: (String value) {},
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Enter your password',
              obscureText: true,
              onChanged: (String value) {},
            ),
          ],
        ),
      ),
    );
  }
}
