import 'package:flutter/material.dart';
import 'colors.dart';

/// Reusable visual effect utilities for the "Space & Sky" design language.
///
/// Provides consistent glow, shadow, and gradient helpers
/// to maintain aesthetic cohesion across all screens.
class AppEffects {
  /// Soft glow shadow for interactive elements (buttons, cards).
  static List<BoxShadow> glowShadow(Color color, {double intensity = 0.3, double blur = 15}) {
    return [
      BoxShadow(
        color: color.withValues(alpha: intensity),
        blurRadius: blur,
        spreadRadius: 2,
      ),
    ];
  }

  /// Accent glow for highlighted/active elements.
  static List<BoxShadow> accentGlow({Color color = AppColors.coolSky}) {
    return glowShadow(color, intensity: 0.5, blur: 20);
  }

  /// Subtle inner shadow for cards and containers.
  static BoxDecoration cardDecoration({
    Color backgroundColor = AppColors.shadowGrey2,
    Color borderColor = AppColors.spaceIndigo,
    double borderRadius = 20,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor.withValues(alpha: 0.3)),
    );
  }

  /// Standard gradient for backgrounds and overlays.
  static LinearGradient skyGradient({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: AppColors.gradientSky,
    );
  }
}
