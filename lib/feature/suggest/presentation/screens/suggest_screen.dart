import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/suggest/bloc/suggest_bloc.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/empty_widget.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/error_widget.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/filter_bottom_sheet.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/genre_section.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/loading_widget.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/mood_grid.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/recommendation_grid.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/runtime_section.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/suggest_header.dart';
import 'package:movie_box/feature/suggest/presentation/widgets/surprise_button.dart';

class SuggestScreen extends StatefulWidget {
  const SuggestScreen({super.key});

  @override
  State<SuggestScreen> createState() => _SuggestScreenState();
}

class _SuggestScreenState extends State<SuggestScreen> {
  final ScrollController _scrollController = ScrollController();
  int? _runtime;
  bool _showMoodSection = true;

  @override
  void initState() {
    super.initState();
    context.read<SuggestBloc>().add(const LoadSuggestions());

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300) {
        context.read<SuggestBloc>().add(const LoadMoreSuggestions());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilters(SuggestLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FilterBottomSheet(
        selectedGenreId: state.selectedGenreId,
        selectedRuntime: _runtime,
        onGenreChanged: (id) {
          if (id != null) {
            context.read<SuggestBloc>().add(SelectGenre(id));
          }
        },
        onRuntimeChanged: (runtime) {
          setState(() => _runtime = runtime);
        },
        onApply: () {},
        onReset: () {
          setState(() => _runtime = null);
          context.read<SuggestBloc>().add(const RefreshSuggestions());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<SuggestBloc, SuggestState>(
        builder: (_, state) {
          if (state is! SuggestLoaded) return const SizedBox.shrink();
          return FloatingActionButton(
            onPressed: () => _showFilters(state),
            child: const Icon(Icons.tune),
          );
        },
      ),
      body: SafeArea(
        child: BlocBuilder<SuggestBloc, SuggestState>(
          builder: (context, state) {
            final bool isInitialLoading =
                state is SuggestInitial || state is SuggestLoading;

            final SuggestLoaded? loadedState =
                state is SuggestLoaded ? state : null;

            final loaded = loadedState;

            if (state is SuggestError) {
              return SuggestErrorWidget(
                message: state.message,
                onRetry: () => context.read<SuggestBloc>().add(const LoadSuggestions()),
              );
            }

            if (state is SuggestLoaded &&
                !state.isLoadingMore &&
                state.recommendations.isEmpty) {
              return SuggestEmptyWidget(
                onRefresh: () => context.read<SuggestBloc>().add(const LoadSuggestions()),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SuggestBloc>().add(const RefreshSuggestions());
              },
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: 100.h),
                children: [
                  const SuggestHeader(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding.w),
                    child: SurpriseButton(
                      onTap: () => context.read<SuggestBloc>().add(const SurpriseMe()),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding.w),
                    child: SegmentedButton<bool>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment<bool>(
                          value: true,
                          label: Text('Mood'),
                        ),
                        ButtonSegment<bool>(
                          value: false,
                          label: Text('Genre'),
                        ),
                      ],
                      selected: {_showMoodSection},
                      onSelectionChanged: (value) {
                        setState(() {
                          _showMoodSection = value.first;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _showMoodSection
                        ? MoodGrid(
                            key: const ValueKey('mood'),
                            selectedMood: loaded?.selectedMood,
                            onMoodSelected: (mood) {
                              setState(() {
                                _showMoodSection = true;
                              });
                              context.read<SuggestBloc>().add(SelectMood(mood));
                            },
                          )
                        : GenreSection(
                            key: const ValueKey('genre'),
                            selectedGenreId: loaded?.selectedGenreId,
                            onGenreSelected: (id) {
                              setState(() {
                                _showMoodSection = false;
                              });
                              context.read<SuggestBloc>().add(SelectGenre(id));
                            },
                          ),
                  ),
                  SizedBox(height: 24.h),
                  RuntimeSection(
                    selectedRuntime: _runtime,
                    onSelected: (value) => setState(() => _runtime = value),
                  ),
                  SizedBox(height: 24.h),
                  RecommendationGrid(
                    movies: loaded?.recommendations ?? const [],
                    isLoadingMore: isInitialLoading || (loaded?.isLoadingMore ?? false),
                    onMovieTap: (movie) {
                      context.push(
                        Routes.detailsScreen,
                        extra: DetailsArguments(
                          id: movie.id,
                          mediaType: movie.mediaType ?? 'movie',
                          heroTag: 'suggest_${movie.id}',
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}