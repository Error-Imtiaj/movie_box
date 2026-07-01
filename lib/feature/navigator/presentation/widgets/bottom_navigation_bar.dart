import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xffE50914);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: const Color(0xff1A1A1F),
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black38,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(Icons.home_rounded, 0),
              _item(Icons.search_rounded, 1),

              GestureDetector(
                onTap: () => onTap(2),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),

              _item(Icons.favorite_rounded, 3),
              _item(Icons.person_rounded, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, int index) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: Icon(
          icon,
          color: selected ? const Color(0xffE50914) : Colors.grey,
          size: selected ? 30 : 26,
        ),
      ),
    );
  }
}