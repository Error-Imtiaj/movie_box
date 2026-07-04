import 'package:flutter/material.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_strings.dart';

class DetailsPoster extends StatelessWidget {
  final String? posterPath;
  final String heroTag;

  const DetailsPoster({
    super.key,
    required this.posterPath,
    required this.heroTag,
  });

  static const imageUrl = AppStrings.tmdbMovieImageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        width: 140,
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AppCachedNetworkImage(
            imageUrl: "$imageUrl${posterPath ?? ""}",
            width: 140,
            height: 210,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}