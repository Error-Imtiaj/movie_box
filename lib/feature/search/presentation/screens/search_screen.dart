import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/search/bloc/search_bloc.dart';
import 'package:movie_box/feature/search/presentation/widgets/empty_search_widget.dart';
import 'package:movie_box/feature/search/presentation/widgets/loading_search_widget.dart';
import 'package:movie_box/feature/search/presentation/widgets/no_result_widget.dart';
import 'package:movie_box/feature/search/presentation/widgets/recent_search_widget.dart';
import 'package:movie_box/feature/search/presentation/widgets/search_bar_widget.dart';
import 'package:movie_box/feature/search/presentation/widgets/search_error_widget.dart';
import 'package:movie_box/feature/search/presentation/widgets/search_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchHeaderDelegate(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.fromLTRB(
                    AppSize.defaultPadding.w,
                    8.h,
                    AppSize.defaultPadding.w,
                    6.h,
                  ),
                  child: SearchBarWidget(
                    controller: _controller,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        context.read<SearchBloc>().add(const ClearSearch());
                      } else {
                        context.read<SearchBloc>().add(
                          SearchMovies(value.trim()),
                        );
                      }
                    },
                    onClear: () {
                      context.read<SearchBloc>().add(const ClearSearch());
                    },
                    onSubmitted: () {
                      if (_controller.text.trim().isNotEmpty) {
                        context.read<SearchBloc>().add(
                          SearchMovies(_controller.text.trim()),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.defaultPadding.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const EmptySearchWidget(),
                          SizedBox(height: 24.h),
                          RecentSearchWidget(
                            searches: const [],
                            onTap: (query) {
                              _controller.text = query;
                              context.read<SearchBloc>().add(
                                SearchMovies(query),
                              );
                            },
                            onRemove: (_) {},
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchLoading) {
                    return const LoadingSearchWidget();
                  }

                  if (state is SearchLoaded) {
                    if (state.movies.isEmpty) {
                      return NoResultWidget(query: _controller.text);
                    }

                    return SearchGrid(
                      movies: state.movies,
                      onMovieTap: (movie) {
                        context.push(
                          Routes.detailsScreen,
                          extra: DetailsArguments(
                            id: movie.id,
                            mediaType: movie.mediaType ?? "movie",
                            heroTag: "${movie.title}_${movie.id}",
                          ),
                        );
                      },
                    );
                  }

                  if (state is SearchError) {
                    return SearchErrorWidget(
                      message: state.message,
                      onRetry: () {
                        if (_controller.text.trim().isNotEmpty) {
                          context.read<SearchBloc>().add(
                            SearchMovies(_controller.text.trim()),
                          );
                        }
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate({required this.child});

  @override
  double get minExtent => 74;

  @override
  double get maxExtent => 74;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) => false;
}
