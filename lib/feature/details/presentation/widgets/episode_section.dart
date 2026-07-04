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
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (episodes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            "No episodes available.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Episodes (${episodes.length})",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 16),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: episodes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, index) {
              final episode = episodes[index];

              return EpisodeCard(
                episode: episode,
                onTap: () => onEpisodeTap?.call(episode),
              );
            },
          ),
        ],
      ),
    );
  }
}