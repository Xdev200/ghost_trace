/// Score-to-Title mapping for the GhostTracer progression system.
///
/// Titles provide aspirational progression feedback and
/// map directly to cumulative score thresholds.
class Titles {
  /// Returns the player's title based on their total score.
  static String getTitle(int totalScore) {
    if (totalScore >= 5000) return 'VOID WALKER';
    if (totalScore >= 2000) return 'Neon Phantom';
    if (totalScore >= 1000) return 'Signal Ghost';
    if (totalScore >= 500) return 'Phantom Coder';
    if (totalScore >= 200) return 'Neon Tracer';
    return 'Ghost Novice';
  }

  /// Returns the next title threshold the player is working toward.
  static int getNextThreshold(int totalScore) {
    if (totalScore >= 5000) return 5000; // Max title
    if (totalScore >= 2000) return 5000;
    if (totalScore >= 1000) return 2000;
    if (totalScore >= 500) return 1000;
    if (totalScore >= 200) return 500;
    return 200;
  }

  /// Score thresholds for reference.
  static const Map<String, int> thresholds = {
    'Ghost Novice': 0,
    'Neon Tracer': 200,
    'Phantom Coder': 500,
    'Signal Ghost': 1000,
    'Neon Phantom': 2000,
    'VOID WALKER': 5000,
  };
}
