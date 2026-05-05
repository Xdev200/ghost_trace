class TitleSystem {
  static String getTitleForScore(int score) {
    if (score < 500) return 'Wandering Spark';
    if (score < 1500) return 'Memory Novice';
    if (score < 4000) return 'Apprentice Tracer';
    if (score < 8000) return 'Adept Pathfinder';
    if (score < 15000) return 'Master Navigator';
    return 'Ghost Tracer';
  }
}
