import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class DisclaimerCard extends StatelessWidget {
  const DisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withOpacity(.15),
        ),
      ),
      child: Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            20,
          ),
          leading: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const HugeIcon(
             icon: HugeIcons.strokeRoundedAlert02,
              color: Colors.orange,
            ),
          ),
          title: const Text(
            "Disclaimer",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: const Text(
            "Read important legal information",
          ),
          children: [
            Text(
              "⚠️ Disclaimer",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "CineVerse does not host, own, or distribute any movies, TV shows, or video content. "
              "All streaming content available through this application is provided solely by third-party services.\n\n"
              "CineVerse is not responsible for the availability, legality, accuracy, or reliability of any third-party content.\n\n"
              "All trademarks, logos, and copyrights are the property of their respective owners.",
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}