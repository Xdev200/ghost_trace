import 'package:hive/hive.dart';
import '../models/game_stats.dart';

class StatsRepository {
  final Box<GameStats> _statsBox;

  StatsRepository(this._statsBox);

  GameStats getStats() {
    return _statsBox.get('current', defaultValue: GameStats())!;
  }

  Future<void> saveStats(GameStats stats) async {
    await _statsBox.put('current', stats);
  }

  Future<void> updateGameResult({
    required int score,
    required int pathLength,
    required bool isSuccess,
    required int correctTaps,
    required int totalTaps,
  }) async {
    final stats = getStats();
    
    stats.totalGamesPlayed++;
    stats.totalScore += score;
    stats.totalCorrectTaps += correctTaps;
    stats.totalTaps += totalTaps;
    stats.lastPlayedDate = DateTime.now();

    if (score > stats.bestRoundScore) {
      stats.bestRoundScore = score;
    }

    if (pathLength > stats.bestPathLength && isSuccess) {
      stats.bestPathLength = pathLength;
    }

    if (isSuccess) {
      stats.currentStreak++;
      if (stats.currentStreak > stats.longestStreak) {
        stats.longestStreak = stats.currentStreak;
      }
    } else {
      stats.currentStreak = 0;
    }

    await saveStats(stats);
  }

  Future<void> resetStats() async {
    await _statsBox.put('current', GameStats());
  }

  Future<void> setPlayerName(String name) async {
    final stats = getStats();
    stats.playerName = name;
    await saveStats(stats);
  }

  Future<void> setTutorialSeen() async {
    final stats = getStats();
    stats.hasSeenTutorial = true;
    await saveStats(stats);
  }
}
