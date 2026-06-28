import 'package:movie_box/core/const/app_asset.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

const onboardingData = [
  OnboardingModel(
    image: AppAsset.onboarding1,
    title: 'Unlimited Movies',
    description:
        'Discover thousands of movies and TV shows from every genre.',
  ),
  OnboardingModel(
    image: AppAsset.onboarding2,
    title: 'Watch Anywhere',
    description:
        'Enjoy your favorite movies anytime on your phone or tablet.',
  ),
  OnboardingModel(
    image: AppAsset.onboarding3,
    title: 'Ready to Explore?',
    description:
        'Create your own watchlist and start your entertainment journey.',
  ),
];