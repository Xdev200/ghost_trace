import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/game/game_grid.dart';
import '../widgets/common/neon_button.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    
    // Auto-navigate to result screen on game over
    ref.listen(gameStateProvider, (previous, next) {
      if (next.status == GameStatus.gameOver) {
        Navigator.pushReplacementNamed(context, '/result');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                _buildHeader(gameState),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: GameGrid(),
                ),
                const Spacer(),
                _buildFooter(gameState),
                const SizedBox(height: 40),
              ],
            ),
            if (gameState.status == GameStatus.countdown)
              _buildCountdownOverlay(gameState.countdownValue),
            if (gameState.status == GameStatus.levelComplete)
              _buildOverlay(
                context,
                title: 'EXCELLENT!',
                message: 'Next level is ready.',
                buttonText: 'NEXT LEVEL',
                onPressed: () => ref.read(gameStateProvider.notifier).nextLevel(),
                color: AppColors.mintGlow,
              ),
            if (gameState.status == GameStatus.error)
              Builder(
                builder: (context) {
                  final playerName = ref.read(statsRepositoryProvider).getStats().playerName;
                  return _buildOverlay(
                    context,
                    title: 'OOPS, ${playerName.toUpperCase()}!',
                    message: 'That was the wrong dot. You lost a life! Watch the sequence again.',
                    buttonText: 'RETRY',
                    onPressed: () => ref.read(gameStateProvider.notifier).retry(),
                    color: AppColors.error,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownOverlay(int value) {
    return Container(
      color: AppColors.background.withValues(alpha: 0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GET READY',
              style: AppTextStyles.subHeading.copyWith(color: AppColors.coolSky, letterSpacing: 8),
            ).animate().fadeIn().scale(),
            const SizedBox(height: 20),
            Text(
              '$value',
              style: AppTextStyles.heading.copyWith(fontSize: 120, color: AppColors.white),
            ).animate(key: ValueKey(value)).scale(duration: 400.ms, curve: Curves.easeOutBack).fadeIn(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(GameState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('LEVEL', style: AppTextStyles.subHeading.copyWith(fontSize: 12)),
              Text('${state.currentLevel}', style: AppTextStyles.stats.copyWith(color: AppColors.coolSky)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('SCORE', style: AppTextStyles.subHeading.copyWith(fontSize: 12)),
              Text('${state.score}', style: AppTextStyles.stats.copyWith(color: AppColors.jasmine))
                  .animate(key: ValueKey(state.score))
                  .scale(duration: 300.ms, begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
                  .then()
                  .scale(duration: 300.ms, begin: const Offset(1.2, 1.2), end: const Offset(1, 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(GameState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isFilled = index < state.lives;
        return Icon(
          Icons.favorite_rounded,
          color: isFilled ? AppColors.magenta : AppColors.spaceIndigo,
          size: 32,
        ).animate(target: isFilled ? 1 : 0).scale(duration: 400.ms);
      }),
    );
  }

  Widget _buildOverlay(
    BuildContext context, {
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      color: AppColors.background.withValues(alpha: 0.8),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.shadowGrey,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(title, style: AppTextStyles.heading.copyWith(color: color, fontSize: 28)),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.powderBlue),
              ),
              const SizedBox(height: 32),
              NeonButton(
                text: buttonText,
                color: color,
                onPressed: onPressed,
              ),
            ],
          ),
        ).animate().scale(curve: Curves.easeOutBack),
      ),
    );
  }
}
