import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_card.dart';

class SearchGrid extends StatelessWidget {
  final List<MovieModel> movies;
  final ValueChanged<MovieModel>? onMovieTap;

  const SearchGrid({
    super.key,
    required this.movies,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text('No movies found.'),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPadding.w,
        vertical: 8.h,
      ),
      itemCount: movies.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 18.h,

        // Adjust this if needed depending on your MovieCard height
        childAspectRatio: .58,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];

        return MovieCard(
          movie: movie,
          heroTag: "search_${movie.id}",
          onTap: () => onMovieTap?.call(movie),
        );
      },
    );
  }
}