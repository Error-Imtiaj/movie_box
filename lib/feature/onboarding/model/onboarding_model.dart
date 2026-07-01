import 'package:movie_box/core/const/app_asset.dart';
import 'package:movie_box/core/const/app_strings.dart';

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
    title: AppStrings.onboardingTitle1,
    description: AppStrings.onboardingDescription1,
  ),
  OnboardingModel(
    image: AppAsset.onboarding2,
    title: AppStrings.onboardingTitle2,
    description: AppStrings.onboardingDescription2,
  ),
  OnboardingModel(
    image: AppAsset.onboarding3,
    title: AppStrings.onboardingTitle3,
    description: AppStrings.onboardingDescription3,
  ),
];