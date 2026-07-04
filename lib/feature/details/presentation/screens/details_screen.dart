import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/feature/details/bloc/details_bloc.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/details/model/movie_details_model.dart';
import 'package:movie_box/feature/details/model/tv_details_model.dart';
import 'package:movie_box/feature/details/model/season_model.dart';
import 'package:movie_box/feature/details/presentation/widgets/cast_section.dart';
import 'package:movie_box/feature/details/presentation/widgets/details_header.dart';
import 'package:movie_box/feature/details/presentation/widgets/details_shimmer.dart';
import 'package:movie_box/feature/details/presentation/widgets/genre_chip.dart';
import 'package:movie_box/feature/details/presentation/widgets/info_tile.dart';
import 'package:movie_box/feature/details/presentation/widgets/overview_widget.dart';
import 'package:movie_box/feature/details/presentation/widgets/play_button.dart';
import 'package:movie_box/feature/details/presentation/widgets/recommendation_section.dart';
import 'package:movie_box/feature/details/presentation/widgets/season_dropdown.dart';
import 'package:movie_box/feature/details/presentation/widgets/episode_section.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/feature/details/presentation/widgets/trailer_dialog.dart';

class DetailsScreen extends StatefulWidget {
  final DetailsArguments arguments;
  const DetailsScreen({super.key, required this.arguments});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showCollapsedTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      const double collapseOffset = 340.0;
      final show =
          _scrollController.hasClients &&
          _scrollController.offset >= collapseOffset;
      if (show != _showCollapsedTitle) {
        setState(() {
          _showCollapsedTitle = show;
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
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.arguments.mediaType == 'movie' ? 'Movie Details' : 'TV Show Details',
      //     maxLines: 1,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // ),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const DetailsShimmer();
          } else if (state is DetailsLoaded) {
            final details = state.details;
            final bool isMovie = details is MovieDetailsModel;
            final movie = isMovie ? details : null;
            final tv = !isMovie ? details as TvDetailsModel : null;
            print("DetailsScreen: isMovie: $isMovie, movie: $movie, tv: $tv");
            print("image url: ${details.backdropPath}");
            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsHeader(
                            title: isMovie ? movie!.title : tv!.name,
                            backdropPath: details.backdropPath,
                            posterPath: details.posterPath,
                            overview: details.overview,
                            rating: details.voteAverage,
                            releaseDate: isMovie
                                ? (movie!.releaseDate)
                                : tv!.firstAirDate,
                            genres: (isMovie ? movie!.genres : tv!.genres)
                                .map((e) => e.name)
                                .toList(),
                            isTv: !isMovie,
                            runtime: isMovie
                                ? ('${movie?.runtime} min')
                                : (tv!.episodeRunTime.isNotEmpty
                                      ? '${tv.episodeRunTime.first} min'
                                      : null),
                            onPlayTrailer: () {
                              // debugPrint(
                              //   "Videos loaded: ${state.videos.length}",
                              // );
                              // print("Play trailer button pressed");
                              // print(
                              //   "Videos: ${state.videos} and isempty: ${state.videos.isEmpty}",
                              // );
                              // if (state.videos.isEmpty) return;

                              // final trailer = state.videos.firstWhere(
                              //   (video) =>
                              //       video.site == "YouTube" &&
                              //       video.type == "Trailer",
                              //   orElse: () => state.videos.first,
                              // );

                              // context.push(
                              //   Routes.trailerPlayerScreen,
                              //   extra: TrailerPlayerArguments(
                              //     youtubeKey: trailer.key,
                              //     title: isMovie ? movie!.title : tv!.name,
                              //   ),
                              // );

                              debugPrint("BUTTON PRESSED");
                            },
                          ),
                          //    PlayButton(text: "Watch Now", icon: AppIcons.playIcon, onTap: () {}),
                          const SizedBox(height: 90),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Row(
                              children: [
                                PlayButton(
                                  text: "Play Now",
                                  icon: AppIcons.playIcon,
                                  onTap: () {},
                                ),
                                const SizedBox(width: 12),
                                PlayButton(
                                  text: "Watch Trailer",
                                  icon: AppIcons.playIcon,
                                  onTap: () {
                                    debugPrint(
                                      "Videos loaded: ${state.videos.length}",
                                    );
                                    print("Play trailer button pressed");
                                    print(
                                      "Videos: ${state.videos} and isempty: ${state.videos.isEmpty}",
                                    );
                                    if (state.videos.isEmpty) return;

                                    final trailer = state.videos.firstWhere(
                                      (video) =>
                                          video.site == "YouTube" &&
                                          video.type == "Trailer",
                                      orElse: () => state.videos.first,
                                    );

                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (_) => TrailerDialog(
                                        youtubeKey: trailer.key,
                                        title: isMovie
                                            ? movie!.title
                                            : tv!.name,
                                      ),
                                    );

                                    debugPrint("BUTTON PRESSED");
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (isMovie ? movie!.genres : tv!.genres)
                                  .map<Widget>((g) => GenreChip(genre: g))
                                  .toList(),
                            ),
                          ),
                          // const SizedBox(height: 24),
                          OverviewWidget(overview: details.overview),
                          //   const SizedBox(height: 24),
                          CastSection(casts: state.casts),
                          // const SizedBox(height: 24),
                          if (isMovie) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                'Movie Info',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InfoTile(
                                      icon: Icons.calendar_today_rounded,
                                      title: 'Release Date',
                                      value: movie!.releaseDate ?? '-',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: InfoTile(
                                      icon: Icons.schedule_rounded,
                                      title: 'Runtime',
                                      value: movie.runtime != null
                                          ? '${movie.runtime} min'
                                          : '-',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          if (!isMovie) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                'Seasons',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SeasonDropdown(
                              seasons: tv!.seasons,
                              selectedSeason: tv.seasons.firstWhere(
                                (SeasonModel season) =>
                                    season.seasonNumber == state.selectedSeason,
                                orElse: () => tv.seasons.first,
                              ),
                              onChanged: (season) {
                                if (season != null) {
                                  context.read<DetailsBloc>().add(
                                    ChangeSeasonEvent(season.seasonNumber),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                'Episodes',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            // const SizedBox(height: 16),
                            EpisodeSection(
                              episodes: state.episodes,
                              isLoading: state.isLoadingEpisodes,
                            ),
                            // const SizedBox(height: 24),
                          ],
                          // Text(
                          //   'Recommendations',
                          //   style: theme.textTheme.titleMedium,
                          // ),
                          //const SizedBox(height: 16),
                          SafeArea(child: RecommendationSection(movies: state.recommendations)),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: MediaQuery.of(context).padding.top + 52,
                    color: _showCollapsedTitle
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.transparent,
                    child: SafeArea(
                      bottom: false,
                      child: SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: _showCollapsedTitle
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Colors.white,
                              ),
                            ),
                            Expanded(
                              child: AnimatedOpacity(
                                opacity: _showCollapsedTitle ? 1 : 0,
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  isMovie ? movie!.title : tv!.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is DetailsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
