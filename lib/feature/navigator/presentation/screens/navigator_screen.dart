import 'package:flutter/material.dart';
import 'package:movie_box/feature/discover/presentation/screens/discover_screen.dart';
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

  final pages = const [
    MovieScreen(),
    SearchScreen(),
    DiscoverScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: currentIndex, children: pages),
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
