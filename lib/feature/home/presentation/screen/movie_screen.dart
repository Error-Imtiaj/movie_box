import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/common/app_error_screen.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/home/bloc/home_bloc.dart';
import 'package:movie_box/feature/home/presentation/shimmer/home_shimmer.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_category.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_section.dart';
import 'package:movie_box/feature/home/presentation/widgets/trending_slider.dart';
import 'package:movie_box/feature/seeall/model/see_all_aurgument_model.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeEvent());
    _scrollController.addListener(() {
      final show = _scrollController.offset > 250;
      if (show != _showAppBar) {
        setState(() {
          _showAppBar = show;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const HomeShimmer();
              }

              if (state is HomeLoaded) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: TrendingSlider(movies: state.trendingAll.results),
                    ),

                    SliverSafeArea(
                      top: false,
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          MovieSection(
                            title: AppStrings.trendingAll,
                            movies: state.trendingAll.results,
                            onSeeAll: () {
                              context.push(
                                Routes.seeAllScreen,
                                extra: const SeeAllArguments(
                                  title: AppStrings.trendingAll,
                                  category: MovieCategory.trendingAll,
                                ),
                              );
                            },
                          ),

                          MovieSection(
                            title: AppStrings.popularMovies,
                            movies: state.popularMovies.results,
                            onSeeAll: () {
                              context.push(
                                Routes.seeAllScreen,
                                extra: const SeeAllArguments(
                                  title: AppStrings.popularMovies,
                                  category: MovieCategory.popularMovie,
                                ),
                              );
                            },
                          ),

                          MovieSection(
                            title: AppStrings.topRatedMovies,
                            movies: state.topRatedMovies.results,
                            onSeeAll: () {
                              context.push(
                                Routes.seeAllScreen,
                                extra: const SeeAllArguments(
                                  title: AppStrings.topRatedMovies,
                                  category: MovieCategory.topRatedMovie,
                                ),
                              );
                            },
                          ),

                          MovieSection(
                            title: AppStrings.trendingTV,
                            movies: state.trendingTv.results,
                            onSeeAll: () {
                              context.push(
                                Routes.seeAllScreen,
                                extra: const SeeAllArguments(
                                  title: AppStrings.trendingTV,
                                  category: MovieCategory.trendingTv,
                                ),
                              );
                            },
                          ),

                          MovieSection(
                            title: AppStrings.popularTV,
                            movies: state.popularTv.results,
                            onSeeAll: () {
                              context.push(
                                Routes.seeAllScreen,
                                extra: const SeeAllArguments(
                                  title: AppStrings.popularTV,
                                  category: MovieCategory.popularTv,
                                ),
                              );
                            },
                          ),

                          MovieSection(
                            title: AppStrings.topRatedTV,
                            movies: state.topRatedTv.results,
                            onSeeAll: () {
                              context.push(
                                Routes.seeAllScreen,
                                extra: const SeeAllArguments(
                                  title: AppStrings.topRatedTV,
                                  category: MovieCategory.topRatedTv,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30.h),
                        ]),
                      ),
                    ),
                  ],
                );
              }

              if (state is HomeError) {
                return AppErrorScreen(
                  message: state.message,
                  onRetry: () {
                    context.read<HomeBloc>().add(LoadHomeEvent());
                  },
                );
              }

              return const SizedBox();
            },
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: _showAppBar ? 0 : -100,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showAppBar ? 1 : 0,
              child: AppBar(
                elevation: 0,
                backgroundColor: AppColors.homeScreenSeeAllBackgroundColor,
                centerTitle: false,
                title: Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.navigationBarSelectedItemColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
