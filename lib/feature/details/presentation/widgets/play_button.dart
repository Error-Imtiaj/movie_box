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
    this.onTap,
    this.outlined = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              outlined ? Colors.transparent : AppColors.homeScreenSeeAllBackgroundColor,
          foregroundColor:
              outlined ? primary : Colors.white,
          side: outlined
              ? BorderSide(
                  color: primary.withOpacity(.4),
                )
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: icon != null
            ? HugeIcon(
                icon :icon,
                size: 20,
              )
            : HugeIcon(
                icon: AppIcons.playIcon,
                size: 20,
                color: outlined ? primary : Colors.white,
              ),
        label: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}