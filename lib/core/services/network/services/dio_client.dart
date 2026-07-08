import 'package:dio/dio.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/core/services/network/services/api_constants.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (!options.queryParameters.containsKey("api_key")) {
            final apiKey = getIt<LocalStorageService>().getApiKey;

            if (apiKey.isNotEmpty) {
              options.queryParameters["api_key"] = apiKey;
            }
          }
          handler.next(options);
        },
      ),
    );
  }
}
