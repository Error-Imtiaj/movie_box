import 'package:flutter/material.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/seeall/presentation/widgets/movie_grid_item.dart';

class RecommendationSection extends StatelessWidget {
  final List<MovieModel> movies;
  final VoidCallback? onSeeAll;
  final ValueChanged<MovieModel>? onTap;

  const RecommendationSection({
    super.key,
    required this.movies,
    this.onSeeAll,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox();
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "More Like This",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  child: const Text("See All"),
                ),
            ],
          ),
      
          const SizedBox(height: 16),
      
          SizedBox(
            height: 300,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) {
                final movie = movies[index];
      
                return SizedBox(
                  width: 165,
                  child: MovieGridItem(
                    movie: movie,
                    heroTag: "recommend_${movie.id}",
                    onTap: () => onTap?.call(movie),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}