import 'package:flutter/material.dart';
import 'package:movie_box/feature/details/model/episode_model.dart';
import 'package:movie_box/feature/details/presentation/widgets/episode_card.dart';

class EpisodeSection extends StatelessWidget {
  final List<EpisodeModel> episodes;
  final bool isLoading;
  final ValueChanged<EpisodeModel>? onEpisodeTap;

  const EpisodeSection({
    super.key,
    required this.episodes,
    required this.isLoading,
    this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (episodes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text("No episodes available."),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: episodes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          return EpisodeCard(
            episode: episodes[index],
            onTap: () => onEpisodeTap?.call(episodes[index]),
          );
        },
      ),
    );
  }
}