import 'package:flutter/material.dart';
import 'package:movie_box/core/helper/app_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          const AppShimmer(
            width: double.infinity,
            height: 500,
          ),

          const SizedBox(height: 24),

          _buildSection(),

          const SizedBox(height: 24),

          _buildSection(),

          const SizedBox(height: 24),

          _buildSection(),

          const SizedBox(height: 24),

          _buildSection(),
        ],
      ),
    );
  }

  Widget _buildSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AppShimmer(
            width: 150,
            height: 20,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, __) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                    width: 140,
                    height: 200,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),

                  SizedBox(height: 10),

                  AppShimmer(
                    width: 120,
                    height: 14,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),

                  SizedBox(height: 8),

                  AppShimmer(
                    width: 80,
                    height: 10,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}