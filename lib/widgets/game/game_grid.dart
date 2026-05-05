import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/game_provider.dart';
import '../../constants/game_config.dart';
import 'game_dot.dart';
import 'path_painter.dart';
import '../../theme/colors.dart';

class GameGrid extends ConsumerStatefulWidget {
  const GameGrid({super.key});

  @override
  ConsumerState<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends ConsumerState<GameGrid> {
  int? _highlightedIndex;
  
  @override
  void initState() {
    super.initState();
    _startPathAnimation();
  }

  void _startPathAnimation() async {
    final gameState = ref.read(gameStateProvider);
    if (gameState.status != GameStatus.showingPath) return;

    for (var index in gameState.targetPath) {
      if (!mounted) return;
      setState(() => _highlightedIndex = index);
      await Future.delayed(GameConfig.interDotDelay);
      setState(() => _highlightedIndex = null);
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (mounted) {
      ref.read(gameStateProvider.notifier).setInputWaiting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    
    // Listen for status changes to restart animation if needed
    ref.listen(gameStateProvider, (previous, next) {
      if (next.status == GameStatus.showingPath && previous?.status != GameStatus.showingPath) {
        _startPathAnimation();
      }
    });

    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          // Background Path Layer
          if (gameState.userPath.isNotEmpty)
            Positioned.fill(
              child: CustomPaint(
                painter: PathPainter(
                  pathIndices: gameState.userPath,
                  pathColor: AppColors.mintGlow,
                  glowIntensity: 0.6,
                ),
              ),
            ),
          
          // Interactive Dot Layer
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: GameConfig.gridSize,
            ),
            itemCount: GameConfig.totalDots,
            itemBuilder: (context, index) {
              final isCorrectlyTapped = gameState.userPath.contains(index);
              final isCurrentTarget = _highlightedIndex == index;
              final isFailed = gameState.failedIndex == index;
              
              Color highlightColor = AppColors.coolSky;
              if (isFailed) {
                highlightColor = AppColors.error;
              } else if (isCorrectlyTapped) {
                highlightColor = AppColors.mintGlow;
              }

              return GameDot(
                isHighlighted: isCurrentTarget || isCorrectlyTapped || isFailed,
                isUserTapped: isCorrectlyTapped,
                highlightColor: highlightColor,
                onTap: () {
                  ref.read(gameStateProvider.notifier).onDotTapped(index);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
