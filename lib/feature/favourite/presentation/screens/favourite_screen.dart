import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/favourite/bloc/favourite_bloc.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_card.dart';
import 'package:movie_box/feature/navigator/bloc/navigator_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouriteBloc>().add(const LoadFavourites());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist')),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            if (state.movies.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90.w,
                        height: 90.h,
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedFavourite,
                          size: 10,
                          color: AppColors.homeScreenSeeAllBackgroundColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Your Watchlist is Empty',
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Tap the heart icon on any movie or TV show to save it here and build your personal watchlist.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      FilledButton.icon(
                        onPressed: () {
                          context.read<NavigatorBloc>().add(
                            const ChangeNavigationIndex(2),
                          );
                        },
                        icon: const Icon(Icons.explore_outlined),
                        label: const Text('Discover Movies'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 18.h,
                  childAspectRatio: .58,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: state.movies[index],
                    onTap: () {
                      // Navigate to movie details
                      context.push(
                        Routes.detailsScreen,
                        extra: DetailsArguments(
                          id: state.movies[index].id,
                          mediaType: state.movies[index].mediaType ?? "movie",
                          heroTag:
                              "${state.movies[index].title}_${state.movies[index].id}",
                        ),
                      );
                    },
                  );
                },
              );
            }
          } else if (state is FavouriteError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
