import 'package:flutter/material.dart';
import 'package:movie_box/feature/seeall/presentation/widgets/movie_grid_skeletone.dart';

class MovieGridLoading extends StatelessWidget {
  const MovieGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
        childAspectRatio: .62,
      ),
      itemBuilder: (_, __) => const MovieGridSkeleton(),
    );
  }
}