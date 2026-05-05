class GameConfig {
  static const int gridSize = 4;
  static const int totalDots = gridSize * gridSize;
  
  static const double dotSize = 72.0;
  static const double dotGap = 16.0;
  
  static const int initialPathLength = 3;
  static const int maxPathLength = 12;
  
  static const Duration initialShowDuration = Duration(milliseconds: 2500);
  static const Duration minShowDuration = Duration(milliseconds: 800);
  static const Duration interDotDelay = Duration(milliseconds: 400);
  static const Duration simultaneousShowDuration = Duration(milliseconds: 1200);
  
  static const double minEuclideanDistance = 1.5;
  
  static const int traceTimeLimitBase = 10; // seconds
}
