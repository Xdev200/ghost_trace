import 'package:flutter_test/flutter_test.dart';
import 'package:ghost_tracer/logic/scorer.dart';
import 'package:ghost_tracer/logic/title_system.dart';
import 'package:ghost_tracer/logic/sequence_generator.dart';
import 'package:ghost_tracer/services/path_generator.dart';

void main() {
  group('Scorer Engine Tests', () {
    test('Perfect tap accuracy without speed penalty returns expected base score', () {
      final score = Scorer.calculateRoundScore(
        pathLength: 3,
        correctTaps: 3,
        totalTaps: 3,
        elapsedMs: 2000, // fast enough to not get heavily penalized, but not ultra fast
      );
      
      // Base: 3 * 100 = 300
      // Accuracy: 3/3 = 1.0
      // Speed multiplier: should be > 1.0 or at least valid
      expect(score, greaterThan(300));
    });

    test('Poor accuracy reduces score significantly', () {
      final perfectScore = Scorer.calculateRoundScore(
        pathLength: 5,
        correctTaps: 5,
        totalTaps: 5,
        elapsedMs: 5000,
      );

      final poorScore = Scorer.calculateRoundScore(
        pathLength: 5,
        correctTaps: 5,
        totalTaps: 10, // 50% accuracy
        elapsedMs: 5000,
      );

      expect(poorScore, lessThan(perfectScore));
    });
  });

  group('Title System Tests', () {
    test('Returns correct titles for score thresholds', () {
      expect(TitleSystem.getTitleForScore(0), 'Wandering Spark');
      expect(TitleSystem.getTitleForScore(1000), 'Memory Novice');
      expect(TitleSystem.getTitleForScore(3000), 'Apprentice Tracer');
      expect(TitleSystem.getTitleForScore(6000), 'Adept Pathfinder');
      expect(TitleSystem.getTitleForScore(12000), 'Master Navigator');
      expect(TitleSystem.getTitleForScore(20000), 'Ghost Tracer');
    });
  });

  group('Sequence Generator Tests', () {
    late SequenceGenerator sequenceGenerator;

    setUp(() {
      sequenceGenerator = SequenceGenerator(PathGenerator());
    });

    test('Generates path of appropriate length based on level', () {
      final pathLvl1 = sequenceGenerator.generateForLevel(1);
      final pathLvl2 = sequenceGenerator.generateForLevel(2);
      final pathLvl5 = sequenceGenerator.generateForLevel(5);

      // We expect paths to generally increase or maintain length
      expect(pathLvl1.length, greaterThanOrEqualTo(3));
      expect(pathLvl5.length, greaterThan(pathLvl1.length));
    });

    test('Path contains only valid grid indices (0-15)', () {
      final path = sequenceGenerator.generateForLevel(10);
      for (final index in path) {
        expect(index, greaterThanOrEqualTo(0));
        expect(index, lessThan(16));
      }
    });

    test('Path does not contain consecutive duplicate indices', () {
      final path = sequenceGenerator.generateForLevel(10);
      for (int i = 0; i < path.length - 1; i++) {
        expect(path[i] == path[i+1], isFalse);
      }
    });
  });
}
