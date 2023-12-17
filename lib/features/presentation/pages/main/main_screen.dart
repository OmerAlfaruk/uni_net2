import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/presentation/pages/main/home/home.dart';
import 'package:uni_link/features/presentation/pages/main/network/network.dart';
import 'package:uni_link/features/presentation/pages/main/notifications/notifications.dart';
import 'package:uni_link/features/presentation/pages/main/post/post.dart';
import 'package:uni_link/features/presentation/pages/main/profile/profile.dart';
import 'package:uni_link/features/presentation/pages/main/search/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: oPrimaryColor,
          unselectedItemColor: Colors.blue.shade300,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 35,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 35,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 35,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervised_user_circle_outlined,
                  size: 35,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 35,
                ),
                label: ""),
          ],
          onTap: navigationTapped,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
              HomePage(),
              SearchPage(),
              Post(),
              NetworkPage(),
              ProfilePage()
          ],
        ),
      ),
    );
  }
}
