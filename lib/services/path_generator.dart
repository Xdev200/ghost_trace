import 'dart:math';
import '../constants/game_config.dart';

class PathGenerator {
  final Random _random = Random();

  /// Generates a list of indices (0 to 15) for a 4x4 grid.
  List<int> generatePath(int length) {
    if (length <= 0) return [];
    
    List<int> path = [];
    int lastIndex = _random.nextInt(GameConfig.totalDots);
    path.add(lastIndex);

    while (path.length < length) {
      int nextIndex = _random.nextInt(GameConfig.totalDots);
      
      // Basic rules: 
      // 1. Cannot be the same as the previous dot
      // 2. Preferably not immediately adjacent to the previous dot (to make tracing harder)
      // 3. But must be within a reasonable "traceable" distance
      if (nextIndex != lastIndex && !path.contains(nextIndex)) {
        // Optional: Add Euclidean distance check if needed from GameConfig
        if (_isReasonableDistance(lastIndex, nextIndex)) {
          path.add(nextIndex);
          lastIndex = nextIndex;
        }
      }
    }
    return path;
  }

  bool _isReasonableDistance(int start, int end) {
    int startX = start % GameConfig.gridSize;
    int startY = start ~/ GameConfig.gridSize;
    int endX = end % GameConfig.gridSize;
    int endY = end ~/ GameConfig.gridSize;

    double distance = sqrt(pow(startX - endX, 2) + pow(startY - endY, 2));
    
    // Ensure dots aren't too close together to make the path more interesting
    return distance >= GameConfig.minEuclideanDistance;
  }
}
