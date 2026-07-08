import 'package:flutter/material.dart';
import 'episode_card_shimmer.dart';

class EpisodeSectionShimmer extends StatelessWidget {
  const EpisodeSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        padding: EdgeInsets.zero,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, __) => const EpisodeCardShimmer(),
      ),
    );
  }
}