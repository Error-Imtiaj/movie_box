import 'package:flutter/material.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_list.dart';
import 'package:movie_box/feature/home/presentation/widgets/section_header.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final VoidCallback? onSeeAll;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, onSeeAll: onSeeAll),
          const SizedBox(height: 12),
          MovieList(movies: movies, title: title),
        ],
      ),
    );
  }
}
