import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_box/core/const/app_strings.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env[AppStrings.tmdbApiUrl]!;
}