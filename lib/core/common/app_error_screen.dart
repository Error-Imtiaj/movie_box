import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_strings.dart';

class AppErrorScreen extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final bool fullScreen;

  const AppErrorScreen({
    super.key,
    this.title = "Oops!",
    required this.message,
    this.onRetry,
    this.fullScreen = true,
  });

  bool get _isNetworkError {
    final text = message.toLowerCase();
    return text.contains("internet") ||
        text.contains("network") ||
        text.contains("connection") ||
        text.contains("socket");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final child = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: AppColors.homeScreenSeeAllBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: HugeIcon(
                icon: _isNetworkError
                    ? AppIcons.wifiOffIcon
                    : AppIcons.alertIcon,
                color: AppColors.white,
                size: 46,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              _isNetworkError ? AppStrings.noInternetConnection : title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
                _isNetworkError
                    ? AppStrings.errorNoInternetDescription
                  : message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),

            if (onRetry != null) ...[
              const SizedBox(height: 28),

              SizedBox(
                width: 180,
                child: FilledButton.icon(
                  onPressed: onRetry,
                  icon: HugeIcon(icon: AppIcons.reloadIcon, color: AppColors.white),
                  label:  Text(AppStrings.errorButtonText),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (fullScreen) {
      return Scaffold(
        body: SafeArea(
          child: child,
        ),
      );
    }

    return child;
  }
}