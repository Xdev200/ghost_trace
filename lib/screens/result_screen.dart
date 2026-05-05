import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../logic/title_system.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/common/neon_button.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final title = TitleSystem.getTitleForScore(gameState.score);
    final stats = ref.watch(statsProvider);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'MISSION OVER',
                  style: AppTextStyles.heading.copyWith(fontSize: 24, color: AppColors.magenta, letterSpacing: 4),
                ),
              ).animate().shake(duration: 500.ms),
              const SizedBox(height: 8),
              Text(
                stats.playerName.toUpperCase(),
                style: AppTextStyles.subHeading.copyWith(fontSize: 16, color: AppColors.white),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              Text(
                title.toUpperCase(),
                style: AppTextStyles.subHeading.copyWith(fontSize: 18, color: AppColors.pearlAqua, letterSpacing: 4.0),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 40),
              _buildScoreBoard(gameState, stats, ref),
              const SizedBox(height: 60),
              NeonButton(
                text: 'PLAY AGAIN',
                onPressed: () {
                  ref.read(gameStateProvider.notifier).startGame();
                  Navigator.pushReplacementNamed(context, '/game');
                },
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 20),
              NeonButton(
                text: 'HOME',
                color: AppColors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBoard(GameState state, dynamic stats, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.shadowGrey,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(
            'FINAL SCORE',
            style: AppTextStyles.subHeading.copyWith(fontSize: 14, color: AppColors.powderBlue),
          ),
          Text(
            '${state.score}',
            style: AppTextStyles.stats.copyWith(fontSize: 64, color: AppColors.jasmine),
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.spaceIndigo),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('LEVEL', '${state.currentLevel}', AppColors.coolSky),
              _buildStatItem('BEST', '${stats.totalScore}', AppColors.pearlAqua),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).scale();
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.subHeading.copyWith(fontSize: 12, color: AppColors.powderBlue)),
        Text(value, style: AppTextStyles.stats.copyWith(fontSize: 24, color: color)),
      ],
    );
  }
}
