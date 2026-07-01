import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/feature/home/presentation/widgets/api_card_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final TextEditingController _apiKeyController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ApiKeyCard(apicontroller: _apiKeyController, onSubmit: () {
                // Handle the button press action here
                // SET API KEY
                getIt<LocalStorageService>().setApiKey(_apiKeyController.text.trim());
                debugPrint('API Key set: ${_apiKeyController.text}');
                context.go(Routes.navigatorScreen);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
