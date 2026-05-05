import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';

class GameDot extends StatelessWidget {
  final bool isHighlighted;
  final bool isUserTapped;
  final bool isGhost;
  final Color highlightColor;
  final VoidCallback onTap;

  const GameDot({
    super.key,
    required this.isHighlighted,
    required this.isUserTapped,
    this.isGhost = false,
    this.highlightColor = AppColors.coolSky,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isHighlighted 
              ? highlightColor.withValues(alpha: 0.4) 
              : AppColors.shadowGrey.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(
            color: isHighlighted ? highlightColor : AppColors.spaceIndigo.withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: isHighlighted ? [
            BoxShadow(
              color: highlightColor.withValues(alpha: 0.5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ] : [],
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isHighlighted ? AppColors.white : AppColors.spaceIndigo,
              shape: BoxShape.circle,
            ),
          ),
        ),
      )
      .animate(target: isHighlighted ? 1 : 0)
      .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 200.ms)
      .shimmer(duration: 800.ms),
    );
  }
}
