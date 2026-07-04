import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/feature/seeall/bloc/seeall_bloc.dart';
import 'package:movie_box/feature/seeall/model/see_all_aurgument_model.dart';
import 'package:movie_box/feature/seeall/presentation/widgets/movie_grid_item.dart';

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
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 300) {
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
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SeeAllLoaded) {
            return GridView.builder(
              controller: controller,
              padding: const EdgeInsets.all(16),
              itemCount: state.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: .62,
              ),
              itemBuilder: (_, index) {
                final movie = state.movies[index];

                return MovieGridItem(
                  movie: movie,
                  heroTag: "${widget.arguments.title}_${movie.id}",
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
