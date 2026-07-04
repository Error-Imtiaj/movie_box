import 'package:flutter/material.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class DetailsShimmer extends StatelessWidget {
  const DetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Backdrop
            Container(
              width: double.infinity,
              height: 340,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            /// Poster + Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 22,
                          width: double.infinity,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 10),

                        Container(
                          height: 18,
                          width: 180,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: List.generate(
                            3,
                            (_) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: 140,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Genres
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  4,
                  (_) => Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 24,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 18),

                  ...List.generate(
                    5,
                    (_) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 14,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Cast Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: 100,
                height: 24,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 140,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, __) {
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 70,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            /// Recommendations
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: 180,
                height: 24,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 270,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 120,
                        height: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}