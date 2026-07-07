import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/feature/suggest/presentation/screens/suggest_screen.dart';
import 'package:movie_box/feature/favourite/presentation/screens/favourite_screen.dart';
import 'package:movie_box/feature/home/presentation/screen/movie_screen.dart';
import 'package:movie_box/feature/navigator/presentation/widgets/bottom_navigation_bar.dart';
import 'package:movie_box/feature/profile/presentation/screens/profile_screen.dart';
import 'package:movie_box/feature/search/presentation/screens/search_screen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    MovieScreen(),
    SearchScreen(),
    SuggestScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: IndexedStack(index: currentIndex, children: pages),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.navigationFloatingDockedColor,
        elevation: 8,
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        child: HugeIcon(
          icon: AppIcons.playIcon,
          color: AppColors.navigationBarSelectedItemColor,
          size: 34,
          strokeWidth: 2,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
