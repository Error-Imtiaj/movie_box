import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';

import 'package:movie_box/feature/home/repository/home_repository.dart';

class ProfileRepository {
  final LocalStorageService localStorageService;
  final HomeRepository homeRepository;

  ProfileRepository({
    required this.localStorageService,
    required this.homeRepository,
  });

  /// Get saved API Key
  Future<String> getApiKey() async {
    return localStorageService.getApiKey;
  }

  /// Validate API Key using HomeRepository
  Future<bool> validateApiKey(String apiKey) async {
    return await homeRepository.checkApiKey(apiKey);
  }

  /// Save API Key locally
  Future<void> saveApiKey(String apiKey) async {
    await localStorageService.setApiKey(apiKey);
  }

  /// Remove API Key (optional)
  Future<void> removeApiKey() async {
    await localStorageService.removeApiKey();
  }

  /// Check whether an API Key already exists
  Future<bool> hasApiKey() async {
    return localStorageService.hasApiKey;
  }
}