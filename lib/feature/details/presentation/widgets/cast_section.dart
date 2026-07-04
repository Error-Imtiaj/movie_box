import 'package:flutter/material.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/feature/details/model/cast_model.dart';

class CastSection extends StatelessWidget {
  final List<CastModel> casts;

  const CastSection({super.key, required this.casts});

  static const imageUrl = AppStrings.tmdbProfileImageUrl;

  @override
  Widget build(BuildContext context) {
    if (casts.isEmpty) return const SizedBox();

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Cast",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    
        const SizedBox(height: 12),
    
        SizedBox(
          height: 145,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final cast = casts[index];
    
              return SizedBox(
                width: 80,
                child: Column(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: AppCachedNetworkImage(
                          imageUrl: cast.profilePath != null
                              ? "$imageUrl${cast.profilePath}"
                              : "",
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
    
                    const SizedBox(height: 4),
    
                    Text(
                      cast.name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColorDark
                      ),
                    ),
    
                  // const SizedBox(height: 4),
    
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.navigationBarBackgroundColor,
                       // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cast.character,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
