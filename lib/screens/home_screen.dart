import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/common/neon_button.dart';
import '../theme/effects.dart';
import '../providers/game_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppEffects.skyGradient(),
        ),
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Logo/Title Area
              _buildLogoHeader(stats.playerName),
              const Spacer(),
              // High Score Banner
              _buildHighScoreCard(ref, stats),
              const SizedBox(height: 40),
              // Action Buttons
              NeonButton(
                text: 'NEW GAME',
                onPressed: () => _handleNewGame(context, ref, stats),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2),
              const SizedBox(height: 20),
              NeonButton(
                text: 'STATISTICS',
                color: AppColors.jasmine,
                onPressed: () {
                  Navigator.pushNamed(context, '/stats');
                },
              ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2),
              const SizedBox(height: 20),
              NeonButton(
                text: 'SETTINGS',
                color: AppColors.pearlAqua,
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2),
              const SizedBox(height: 60),
            ],
          ),
          ),
        ),
      ),
    );
  }

  void _handleNewGame(BuildContext context, WidgetRef ref, dynamic stats) async {
    if (stats.playerName.isEmpty) {
      final name = await _showNameDialog(context);
      if (name == null || name.isEmpty) return;
      await ref.read(statsProvider.notifier).setPlayerName(name);
      
      if (!stats.hasSeenTutorial) {
        if (context.mounted) await _showTutorialModal(context, name);
        await ref.read(statsProvider.notifier).setTutorialSeen();
      }
    } else if (!stats.hasSeenTutorial) {
      await _showTutorialModal(context, stats.playerName);
      await ref.read(statsProvider.notifier).setTutorialSeen();
    }

    ref.read(gameStateProvider.notifier).startGame();
    if (context.mounted) {
      Navigator.pushNamed(context, '/game');
    }
  }

  Future<String?> _showNameDialog(BuildContext context) async {
    String name = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.shadowGrey2,
        title: Text('IDENTIFY YOURSELF', style: AppTextStyles.subHeading.copyWith(color: AppColors.coolSky)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your callsign to begin the mission.',
              style: AppTextStyles.body.copyWith(color: AppColors.powderBlue, fontSize: 12),
            ),
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: 'e.g. STARGAZER',
                hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.3)),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.spaceIndigo)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.coolSky)),
              ),
              onChanged: (v) => name = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, name),
            child: const Text('CONFIRM', style: TextStyle(color: AppColors.coolSky, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _showTutorialModal(BuildContext context, String name) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: AppColors.shadowGrey2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.spaceIndigo,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'WELCOME, ${name.toUpperCase()}!',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading.copyWith(fontSize: 24, letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 24),
            _buildTutorialStep(
              Icons.visibility_rounded,
              'MEMORIZE',
              'Watch the path carefully as it illuminates across the grid.',
              AppColors.coolSky,
            ),
            const SizedBox(height: 20),
            _buildTutorialStep(
              Icons.blur_on_rounded,
              'RECALL',
              'The path will fade. Visualize the connection between the dots.',
              AppColors.jasmine,
            ),
            const SizedBox(height: 20),
            _buildTutorialStep(
              Icons.touch_app_rounded,
              'TRACE',
              'Tap the dots in the exact order. Be quick for bonus points!',
              AppColors.pearlAqua,
            ),
            const SizedBox(height: 40),
            NeonButton(
              text: 'I UNDERSTAND',
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorialStep(IconData icon, String title, String desc, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.subHeading.copyWith(color: color, fontSize: 14)),
              Text(desc, style: AppTextStyles.body.copyWith(color: AppColors.powderBlue, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoHeader(String playerName) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.coolSky.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.coolSky, width: 2),
            boxShadow: AppEffects.glowShadow(AppColors.coolSky, intensity: 0.3),
          ),
          child: const Center(
            child: Icon(Icons.blur_on_rounded, color: AppColors.coolSky, size: 40),
          ),
        ).animate(onPlay: (c) => c.repeat()).rotate(duration: 10.seconds),
        const SizedBox(height: 16),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'GHOST TRACER',
            style: AppTextStyles.heading.copyWith(fontSize: 28, letterSpacing: 4),
          ),
        ).animate().shimmer(duration: 2.seconds),
        if (playerName.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'COMMANDER: ${playerName.toUpperCase()}',
            style: AppTextStyles.subHeading.copyWith(fontSize: 12, color: AppColors.powderBlue, letterSpacing: 2),
          ),
        ],
      ],
    );
  }

  Widget _buildHighScoreCard(WidgetRef ref, dynamic stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppEffects.cardDecoration(
        backgroundColor: AppColors.shadowGrey.withValues(alpha: 0.5),
        borderColor: AppColors.white.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events_rounded, color: AppColors.jasmine, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BEST SCORE',
                style: AppTextStyles.subHeading.copyWith(fontSize: 12, color: AppColors.powderBlue),
              ),
              Text(
                stats.totalScore.toString(),
                style: AppTextStyles.stats.copyWith(color: AppColors.jasmine),
              ),
            ],
          ),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BEST PATH',
                style: AppTextStyles.subHeading.copyWith(fontSize: 12, color: AppColors.powderBlue),
              ),
              Text(
                '${stats.bestPathLength}',
                style: AppTextStyles.stats.copyWith(color: AppColors.pearlAqua),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).scale();
  }
}
