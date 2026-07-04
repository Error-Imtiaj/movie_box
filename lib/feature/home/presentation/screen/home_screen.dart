import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/feature/home/bloc/home_bloc.dart';
import 'package:movie_box/feature/home/presentation/widgets/api_card_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController apiKeyController = TextEditingController();
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeApiValid) {
          context.go(Routes.navigatorScreen);
        }
        if (state is HomeApiInvalid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ApiKeyCard(
                      apicontroller: apiKeyController,
                      onSubmit: () {
                        context.read<HomeBloc>().add(
                          SubmitApiKeyEvent(apiKeyController.text.trim()),
                        );
                        print('API Key: ${apiKeyController.text.trim()}');
                      },
                      isLoading: State is HomeLoading,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
