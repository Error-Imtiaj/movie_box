import 'package:flutter/material.dart';
import 'package:movie_box/core/helper/app_shimmer.dart';

class EpisodeCardShimmer extends StatelessWidget {
  const EpisodeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding:  EdgeInsets.symmetric(horizontal: 12),
      height: 110,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(.12),
        ),
      ),
      child: Row(
        children: [
          const AppShimmer(
            width: 140,
            height: 90,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmer(
                  width: 180,
                  height: 16,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),

                SizedBox(height: 8),

                AppShimmer(
                  width: 120,
                  height: 12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),

                SizedBox(height: 10),

                AppShimmer(
                  width: double.infinity,
                  height: 10,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),

                SizedBox(height: 6),

                AppShimmer(
                  width: 180,
                  height: 10,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}