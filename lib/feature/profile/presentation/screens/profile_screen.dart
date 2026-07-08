import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/feature/profile/bloc/profile_bloc.dart';
import 'package:movie_box/feature/profile/presentation/widgets/api_key_card.dart';
import 'package:movie_box/feature/profile/presentation/widgets/change_api_dialog.dart';
import 'package:movie_box/feature/profile/presentation/widgets/disclaimer_card.dart';
import 'package:movie_box/feature/profile/presentation/widgets/profile_header.dart';
import 'package:movie_box/feature/profile/presentation/widgets/settings_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('API Key updated successfully.'), behavior: SnackBarBehavior.floating,),
            );
          }
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ProfileHeader(),
                const SizedBox(height: 24),
                ApiKeyCard(
                  apiKey: state.apiKey,
                  onChangePressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<ProfileBloc>(),
                        child: ChangeApiKeyDialog(currentApiKey: state.apiKey),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                SettingsTile(
                  title: 'Privacy Policy',
                  icon: Icons.privacy_tip_outlined,
                  subtitle: 'Read our privacy policy',
                  onTap: () {},
                ),
                SettingsTile(
                  title: 'About',
                  icon: Icons.info_outline,
                  subtitle: 'Version 1.0.0',
                  showDivider: false,
                  onTap: () {},
                ),
                SizedBox(height: 24.h),
                const DisclaimerCard(),
                SizedBox(height: 140.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
