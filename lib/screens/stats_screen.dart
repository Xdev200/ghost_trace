import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/effects.dart';
import '../providers/game_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('STATISTICS', style: AppTextStyles.heading.copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            if (stats.playerName.isNotEmpty) ...[
              Text(
                'COMMANDER: ${stats.playerName.toUpperCase()}',
                style: AppTextStyles.subHeading.copyWith(color: AppColors.coolSky, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'MISSION LOGS',
                style: AppTextStyles.body.copyWith(color: AppColors.powderBlue, fontSize: 10, letterSpacing: 4),
              ),
              const SizedBox(height: 32),
            ],
            _buildStatCard(
              'TOTAL SCORE',
              stats.totalScore.toString(),
              Icons.stars_rounded,
              AppColors.jasmine,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'BEST ROUND',
                    stats.bestRoundScore.toString(),
                    Icons.emoji_events_rounded,
                    AppColors.coolSky,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'STREAK',
                    stats.longestStreak.toString(),
                    Icons.local_fire_department_rounded,
                    AppColors.magenta,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              'BEST PATH LENGTH',
              stats.bestPathLength.toString(),
              Icons.polyline_rounded,
              AppColors.pearlAqua,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'ACCURACY',
                    '${((stats.totalCorrectTaps / (stats.totalTaps > 0 ? stats.totalTaps : 1)) * 100).toStringAsFixed(1)}%',
                    Icons.track_changes_rounded,
                    AppColors.mintGlow,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'GAMES',
                    stats.totalGamesPlayed.toString(),
                    Icons.videogame_asset_rounded,
                    AppColors.powderBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppEffects.cardDecoration(
        backgroundColor: AppColors.shadowGrey2,
        borderColor: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.subHeading.copyWith(fontSize: 12, color: AppColors.powderBlue),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.stats.copyWith(color: color, fontSize: 24),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}
