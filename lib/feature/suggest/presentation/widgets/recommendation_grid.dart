import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_card.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/loading_widget.dart';

class RecommendationGrid extends StatelessWidget {
  final List<MovieModel> movies;
  final ScrollController? controller;
  final bool isLoadingMore;
  final ValueChanged<MovieModel>? onMovieTap;

  const RecommendationGrid({
    super.key,
    required this.movies,
    this.controller,
    this.isLoadingMore = false,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      if (isLoadingMore) {
        return SuggestLoadingWidget(
          // isLoadingMore: true,
        );
      }

      return const Center(child: Text('No recommendations available.'));
    }

    return GridView.builder(
      controller: controller,
      shrinkWrap: true,
      physics: controller == null
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPadding.w,
        vertical: 8.h,
      ),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 18.h,
        childAspectRatio: .58,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];

        return MovieCard(
          movie: movie,
          heroTag: 'suggest_${movie.id}',
          onTap: () => onMovieTap?.call(movie),
        );
      },
    );
  }
}
