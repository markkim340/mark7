import 'package:flutter/material.dart';
import 'package:mark7/common/const/colors.dart';
import 'package:mark7/common/layout/default_layout.dart';
import 'package:mark7/product/view/product_tab.dart';
import 'package:mark7/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tapListener);
  }

  @override
  void dispose() {
    controller.removeListener(tapListener);
    controller.dispose();
    super.dispose();
  }

  void tapListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Product',
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            selectedItemColor: PRIMARY_COLOR,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            unselectedItemColor: Colors.grey[400],
            unselectedLabelStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            onTap: (int index) {
              controller.animateTo(index);
            },
            currentIndex: index,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Food',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          RestaurantScreen(),
          ProductTab(),
          Center(child: Text('Profile Tab')),
          Center(child: Text('Settings Tab')),
        ],
      ),
    );
  }
}
