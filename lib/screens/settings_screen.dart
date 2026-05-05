import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/effects.dart';
import '../providers/game_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('SETTINGS', style: AppTextStyles.heading.copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('AUDIO & HAPTICS'),
          _buildSettingTile(
            'Sound Effects',
            'Toggle in-game sounds',
            Icons.volume_up_rounded,
            Switch(value: true, onChanged: (v) {}, activeColor: AppColors.coolSky),
          ),
          _buildSettingTile(
            'Haptic Feedback',
            'Physical vibration on tap',
            Icons.vibration_rounded,
            Switch(value: true, onChanged: (v) {}, activeColor: AppColors.coolSky),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('ACCOUNT'),
          _buildSettingTile(
            'Reset Progress',
            'Permanently clear all statistics',
            Icons.delete_forever_rounded,
            TextButton(
              onPressed: () => _showResetDialog(context, ref),
              child: const Text('RESET', style: TextStyle(color: AppColors.error)),
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('ABOUT'),
          _buildSettingTile(
            'Version',
            '1.0.0 (Production Ready)',
            Icons.info_outline_rounded,
            const Text('v1.0', style: TextStyle(color: AppColors.powderBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: AppTextStyles.subHeading.copyWith(fontSize: 14, color: AppColors.coolSky),
      ),
    );
  }

  Widget _buildSettingTile(String title, String subtitle, IconData icon, Widget trailing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: AppEffects.cardDecoration(
        backgroundColor: AppColors.shadowGrey2,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.powderBlue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.subHeading.copyWith(fontSize: 16, color: AppColors.white)),
                Text(subtitle, style: AppTextStyles.body.copyWith(fontSize: 12, color: AppColors.powderBlue)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.shadowGrey2,
        title: const Text('RESET ALL STATS?', style: TextStyle(color: AppColors.white)),
        content: const Text(
          'This will permanently delete your high scores and progress. This action cannot be undone.',
          style: TextStyle(color: AppColors.powderBlue),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: AppColors.powderBlue)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(statsRepositoryProvider).resetStats();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Progress Reset')),
                );
              }
            },
            child: const Text('RESET', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
