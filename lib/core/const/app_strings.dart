class AppStrings {
  // App Strings
  // APP NAME
  static const String appName = 'Movie Box';

  // NETWORK AND INTERNET CONNECTION
  static const String noInternetConnection = 'No Internet Connection';
  static const String backOnline = 'Back Online';

  // ONBOARDING SCREEN
  static const String onboardingTitle1 = 'Unlimited Movies';
  static const String onboardingDescription1 =
      'Discover thousands of movies and TV shows from every genre.';
  static const String onboardingTitle2 = 'Watch Anywhere';
  static const String onboardingDescription2 =
      'Enjoy your favorite movies anytime on your phone or tablet.';
  static const String onboardingTitle3 = 'Ready to Explore?';
  static const String onboardingDescription3 =
      'Create your own watchlist and start your entertainment journey.';
  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String watchNow = 'Watch Now'; 

  // TMDB SCREEN 
  static const String tmdbTitle = 'Connect Your TMDB Key';
  static const String tmdbDescription =
      'Movie Box uses The Movie Database API to fetch real movie and TV data. A free API key is required.';
  static const String tmdbStep1 = 'Create a free account at themoviedb.org';
  static const String tmdbStep2 = 'Go to Settings → API → Request an API key';
  static const String tmdbStep3 = 'Copy your v3 API key and paste it below';
  static const String tmdbHintText = 'Paste your TMDB API key here...';
  static const String openTMDBWebsite = 'Open TMDB website';
  static const String startStreaming = 'Start Streaming';

  // ROUTES
  static const String splashScreen = '/';
  static const String onboardingScreen = '/onboarding';
  static const String homeScreen = '/home';
  static const String navigationScreen = '/navigation';
}
