
/// Scoring engine for GhostTracer.
///
/// Implements the PRD formula:
///   base_score = path_length × 100
///   accuracy_multiplier = (correct_taps / total_taps) × 2.0
///   speed_bonus = max(0, 500 − elapsed_ms_for_trace / path_length)
///   round_score = (base_score × accuracy_multiplier) + speed_bonus
class Scorer {
  /// Calculate round score per PRD specification.
  static int calculateRoundScore({
    required int pathLength,
    required int correctTaps,
    required int totalTaps,
    required int elapsedMs,
  }) {
    if (totalTaps == 0 || pathLength == 0) return 0;

    final baseScore = pathLength * 100;
    final accuracyMultiplier = (correctTaps / totalTaps) * 2.0;
    final speedBonus = (500 - (elapsedMs / pathLength)).clamp(0, 500).toInt();

    return ((baseScore * accuracyMultiplier) + speedBonus).round();
  }

  /// Check if daily bonus applies (1.5x if played yesterday).
  static double getDailyMultiplier(DateTime? lastPlayedDate) {
    if (lastPlayedDate == null) return 1.0;

    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final lastPlayed = DateTime(
      lastPlayedDate.year,
      lastPlayedDate.month,
      lastPlayedDate.day,
    );

    return lastPlayed == yesterday ? 1.5 : 1.0;
  }
}
