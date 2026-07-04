import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_card.dart';

class MovieList extends StatelessWidget {
  final List<MovieModel> movies;
  final String? title;

  const MovieList({super.key, required this.movies, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.movieListBoxHeight.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.movieListBoxHorizontalPadding.w,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            heroTag: title != null ? "${title}_${movie.id}" : null,
            onTap: () {
              context.push(
                Routes.detailsScreen,
                extra: DetailsArguments(
                  id: movie.id,
                  mediaType: movie.mediaType ?? "movie",
                  heroTag: "${title}_${movie.id}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}
