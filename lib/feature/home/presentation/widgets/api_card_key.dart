import 'package:flutter/material.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiKeyCard extends StatelessWidget {
  final TextEditingController apicontroller;
  final VoidCallback onSubmit;
  final bool isLoading;
  const ApiKeyCard({
    super.key,
    required this.apicontroller,
    required this.onSubmit, required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> _openTMDBWebsite() async {
      final Uri url = Uri.parse('https://www.themoviedb.org/signup');

      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.cardColor.withOpacity(.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              const Icon(
                Icons.vpn_key_outlined,
                color: AppColors.textColor,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  AppStrings.tmdbTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
      
          const SizedBox(height: 20),
      
          Text(
            AppStrings.tmdbDescription,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
      
          const SizedBox(height: 32),
      
          const _StepWidget(number: "1", text: AppStrings.tmdbStep1),
      
          const SizedBox(height: 18),
      
          const _StepWidget(number: "2", text: AppStrings.tmdbStep2),
      
          const SizedBox(height: 18),
      
          const _StepWidget(number: "3", text: AppStrings.tmdbStep3),
      
          const SizedBox(height: 32),
      
          InkWell(
            onTap: _openTMDBWebsite,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                const Icon(Icons.open_in_new, color: AppColors.linkTextColor),
                const SizedBox(width: 12),
                Text(
                  AppStrings.openTMDBWebsite,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.linkTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      
          const SizedBox(height: 28),
      
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: apicontroller,
            decoration: InputDecoration(
              hintText: AppStrings.tmdbHintText,
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color(0xff23232C),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
      
          const SizedBox(height: 24),
      
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: const Color(0xff2A2A31),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.startStreaming,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepWidget extends StatelessWidget {
  final String number;
  final String text;

  const _StepWidget({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.textColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              //color: AppColors.textColorLight,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
