import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/global_variables.dart';


import '../utils/colors.dart';

class MobileScreeLayout extends StatefulWidget {
  const MobileScreeLayout({super.key});

  @override
  State<MobileScreeLayout> createState() => _MobileScreeLayoutState();
}

class _MobileScreeLayoutState extends State<MobileScreeLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_page == 0) ? primaryColor : secondaryColor,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: 'search'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: (_page == 2) ? primaryColor : secondaryColor,
            ),
            label: 'addPost',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: 'profile',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
