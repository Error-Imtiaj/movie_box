import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class ApiKeyCard extends StatelessWidget {
  final String apiKey;
  final VoidCallback onChangePressed;

  const ApiKeyCard({
    super.key,
    required this.apiKey,
    required this.onChangePressed,
  });

  String get _maskedKey {
    if (apiKey.isEmpty) return "No API Key";

    if (apiKey.length <= 8) {
      return "*" * apiKey.length;
    }

    return "${apiKey.substring(0, 4)}"
        "${"*" * (apiKey.length - 8)}"
        "${apiKey.substring(apiKey.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.withOpacity(.15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: AppColors.homeScreenSeeAllBackgroundColor.withOpacity(.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedKey01,
                    color: AppColors.homeScreenSeeAllBackgroundColor,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TMDB API Key",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Manage your personal API Key",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                _maskedKey,
                style: const TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onChangePressed,
                icon: const HugeIcon(icon: HugeIcons.strokeRoundedEdit02),
                label: const Text("Change API Key"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}