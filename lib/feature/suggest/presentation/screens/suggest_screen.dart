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
      appBar: AppBar(
        title: const Text('Suggest Me'),
        centerTitle: true,
        elevation: 0,
      ),
      // floatingActionButton: BlocBuilder<SuggestBloc, SuggestState>(
      //   builder: (_, state) {
      //     if (state is! SuggestLoaded) return const SizedBox.shrink();
      //     return FloatingActionButton(
      //       onPressed: () => _showFilters(state),
      //       child: const Icon(Icons.tune),
      //     );
      //   },
      // ),
      body: BlocBuilder<SuggestBloc, SuggestState>(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding.w),
                  child: SurpriseButton(
                    onTap: () => context.read<SuggestBloc>().add(const SurpriseMe()),
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: .45),
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: DropdownMenu<bool>(
                      initialSelection: _showMoodSection,
                      expandedInsets: EdgeInsets.zero,
                      width: double.infinity,
                      leadingIcon: Icon(
                        _showMoodSection
                            ? Icons.sentiment_satisfied_alt_rounded
                            : Icons.movie_filter_rounded,
                      ),
                      trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<bool>(
                          value: true,
                          label: 'Browse by Mood',
                          leadingIcon: Icon(Icons.sentiment_satisfied_alt_rounded),
                        ),
                        DropdownMenuEntry<bool>(
                          value: false,
                          label: 'Browse by Genre',
                          leadingIcon: Icon(Icons.movie_filter_rounded),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == null) return;
                        setState(() {
                          _showMoodSection = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _showMoodSection
                      ? Padding(
                          key: const ValueKey('mood_dropdown'),
                          padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 240.w),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withValues(alpha: .45),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outlineVariant,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: .06),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: DropdownMenu<String>(
                                initialSelection: loaded?.selectedMood,
                                hintText: 'Mood',
                                expandedInsets: EdgeInsets.zero,
                                menuHeight: 320,
                                width: 240.w,
                                leadingIcon: const Icon(Icons.sentiment_satisfied_alt_rounded),
                                trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                                inputDecorationTheme: const InputDecorationTheme(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                  isDense: true,
                                ),
                                dropdownMenuEntries: const [
                                  DropdownMenuEntry(value: 'Happy', label: '😊 Happy'),
                                  DropdownMenuEntry(value: 'Sad', label: '😢 Sad'),
                                  DropdownMenuEntry(value: 'Excited', label: '🤩 Excited'),
                                  DropdownMenuEntry(value: 'Romantic', label: '❤️ Romantic'),
                                  DropdownMenuEntry(value: 'Scary', label: '👻 Scary'),
                                  DropdownMenuEntry(value: 'Funny', label: '😂 Funny'),
                                  DropdownMenuEntry(value: 'Mind-bending', label: '🧠 Mind-bending'),
                                  DropdownMenuEntry(value: 'Dark', label: '🌑 Dark'),
                                ],
                                onSelected: (value) {
                                  if (value != null) {
                                    context.read<SuggestBloc>().add(SelectMood(value));
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      : GenreSection(
                        selectedGenreId: loaded?.selectedGenreId,
                        onGenreSelected: (id) {
                          context.read<SuggestBloc>().add(SelectGenre(id));
                        },
                        useDropdown: true,
                      ),
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
    );
  }
}