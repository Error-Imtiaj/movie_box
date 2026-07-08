import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/seeall/bloc/seeall_bloc.dart';
import 'package:movie_box/feature/seeall/model/see_all_aurgument_model.dart';
import 'package:movie_box/feature/seeall/presentation/widgets/movie_grid_item.dart';
import 'package:movie_box/feature/seeall/presentation/widgets/movie_grid_loading.dart';
import 'package:movie_box/feature/seeall/presentation/widgets/movie_grid_skeletone.dart';

class SeeAllScreen extends StatefulWidget {
  final SeeAllArguments arguments;

  const SeeAllScreen({super.key, required this.arguments});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();

    controller.addListener(() {
      if (!controller.hasClients) return;
      if (controller.position.extentAfter < 400) {
        context.read<SeeAllBloc>().add(LoadMoreMoviesEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.arguments.title)),
      body: BlocBuilder<SeeAllBloc, SeeAllState>(
        builder: (_, state) {
          if (state is SeeAllLoading) {
            return MovieGridLoading();
          }
      
          if (state is SeeAllLoaded) {
            return GridView.builder(
              controller: controller,
              padding: const EdgeInsets.all(16),
              itemCount: state.movies.length + (state.isLoadingMore ? 2 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: .62,
              ),
              itemBuilder: (_, index) {
                if (index >= state.movies.length) {
                  return const MovieGridSkeleton();
                }
      
                return MovieGridItem(
                  movie: state.movies[index],
                  onTap: () {
                    context.push(
                      Routes.detailsScreen,
                      extra: DetailsArguments(
                        id: state.movies[index].id,
                        mediaType: state.movies[index].mediaType ?? "movie",
                        heroTag: "${state.movies[index].title}_${state.movies[index].id}",
                      ),
                    );
                  },
                );
              },
            );
          }
      
          return const SizedBox();
        },
      ),
    );
  }
}
