import 'package:hive/hive.dart';

part 'game_stats.g.dart';

@HiveType(typeId: 0)
class GameStats extends HiveObject {
  @HiveField(0)
  int totalScore;

  @HiveField(1)
  int bestRoundScore;

  @HiveField(2)
  int longestStreak;

  @HiveField(3)
  int currentStreak;

  @HiveField(4)
  int bestPathLength;

  @HiveField(5)
  int totalGamesPlayed;

  @HiveField(6)
  int totalCorrectTaps;

  @HiveField(7)
  int totalTaps;

  @HiveField(8)
  DateTime? lastPlayedDate;

  @HiveField(9)
  String playerName;

  @HiveField(10)
  bool hasSeenTutorial;

  GameStats({
    this.totalScore = 0,
    this.bestRoundScore = 0,
    this.longestStreak = 0,
    this.currentStreak = 0,
    this.bestPathLength = 0,
    this.totalGamesPlayed = 0,
    this.totalCorrectTaps = 0,
    this.totalTaps = 0,
    this.lastPlayedDate,
    this.playerName = '',
    this.hasSeenTutorial = false,
  });
}
