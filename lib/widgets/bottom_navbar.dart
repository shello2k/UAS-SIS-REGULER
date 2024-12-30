import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrystalNavigationBar(
      backgroundColor: Colors.orange,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.white70,
      onTap: onTap,
      items: [
        CrystalNavigationBarItem(
          icon: IconlyBold.home,
          unselectedIcon: IconlyLight.home,
          selectedColor: Colors.white,
        ),
        CrystalNavigationBarItem(
          icon: IconlyBold.heart,
          unselectedIcon: IconlyLight.heart,
          selectedColor: Colors.red,
        ),
        CrystalNavigationBarItem(
          icon: IconlyBold.plus,
          unselectedIcon: IconlyLight.plus,
          selectedColor: Colors.white,
        ),
        CrystalNavigationBarItem(
          icon: IconlyBold.search,
          unselectedIcon: IconlyLight.search,
          selectedColor: Colors.white,
        ),
        CrystalNavigationBarItem(
          icon: IconlyBold.user_2,
          unselectedIcon: IconlyLight.user,
          selectedColor: Colors.white,
        ),
      ],
    );
  }
}
