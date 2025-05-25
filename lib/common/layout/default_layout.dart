import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    super.key,
    this.backgroundColor,
    this.title,
    required this.child,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(title: title),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

AppBar? renderAppBar({
  String? title,
}) {
  if (title == null) {
    return null;
  } else {
    return AppBar(
      elevation: 0,
      title: Text(title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leading: null,
    );
  }
}
