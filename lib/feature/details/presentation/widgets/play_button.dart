import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';

class PlayButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool outlined;
  final List<List<dynamic>> icon;

  const PlayButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: outlined
              ? Colors.transparent
              : AppColors.homeScreenSeeAllBackgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: outlined
              ? Border.all(
                  color: primary.withOpacity(.4),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: icon,
              size: 20,
              color: outlined ? primary : Colors.white,
            ),

            const SizedBox(width: 10),

            Text(
              text,
              style: TextStyle(
                color: outlined ? primary : Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}