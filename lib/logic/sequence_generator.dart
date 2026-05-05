import '../services/path_generator.dart';

/// Pure business logic — sequence generation delegator.
///
/// This lives in the logic/ layer (no Flutter dependencies)
/// to maintain Clean Architecture separation.
/// Currently wraps PathGenerator; in future could implement
/// Strategy Pattern for different difficulty algorithms.
class SequenceGenerator {
  final PathGenerator _pathGenerator;

  SequenceGenerator(this._pathGenerator);

  /// Generate a new sequence for the given difficulty level.
  ///
  /// Path length scales with level per GameConfig rules:
  /// - Starts at initialPathLength (3)
  /// - Increases by 1 every 3 successful rounds
  /// - Capped at maxPathLength (12)
  List<int> generateForLevel(int level) {
    final pathLength = 3 + (level ~/ 3);
    final clampedLength = pathLength.clamp(3, 12);
    return _pathGenerator.generatePath(clampedLength);
  }
}
