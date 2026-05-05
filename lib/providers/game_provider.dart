import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/game_stats.dart';
import '../services/path_generator.dart';
import '../repositories/stats_repository.dart';
import '../services/audio_service.dart';
import '../logic/sequence_generator.dart';
import '../logic/scorer.dart';

enum GameStatus { idle, countdown, showingPath, waitingForInput, calculatingResult, levelComplete, error, gameOver }

class GameState {
  final GameStatus status;
  final List<int> targetPath;
  final List<int> userPath;
  final int currentLevel;
  final int score;
  final int lives;
  final int? failedIndex;
  final int countdownValue;

  GameState({
    this.status = GameStatus.idle,
    this.targetPath = const [],
    this.userPath = const [],
    this.currentLevel = 1,
    this.score = 0,
    this.lives = 3,
    this.failedIndex,
    this.countdownValue = 0,
  });

  GameState copyWith({
    GameStatus? status,
    List<int>? targetPath,
    List<int>? userPath,
    int? currentLevel,
    int? score,
    int? lives,
    int? failedIndex,
    int? countdownValue,
    bool clearFailedIndex = false,
  }) {
    return GameState(
      status: status ?? this.status,
      targetPath: targetPath ?? this.targetPath,
      userPath: userPath ?? this.userPath,
      currentLevel: currentLevel ?? this.currentLevel,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      failedIndex: clearFailedIndex ? null : (failedIndex ?? this.failedIndex),
      countdownValue: countdownValue ?? this.countdownValue,
    );
  }
}

class GameNotifier extends StateNotifier<GameState> {
  final SequenceGenerator _sequenceGenerator;
  final StatsNotifier _statsNotifier;
  
  DateTime? _roundStartTime;
  int _roundTotalTaps = 0;
  int _roundCorrectTaps = 0;

  GameNotifier(this._sequenceGenerator, this._statsNotifier) : super(GameState());

  void startGame() {
    state = GameState(status: GameStatus.idle, currentLevel: 1, score: 0, lives: 3);
    _startCountdown();
  }

  Future<void> _startCountdown() async {
    state = state.copyWith(status: GameStatus.countdown, countdownValue: 3);
    
    for (int i = 3; i > 0; i--) {
      if (state.status != GameStatus.countdown) return;
      state = state.copyWith(countdownValue: i);
      AudioService.triggerHaptic();
      await Future.delayed(const Duration(seconds: 1));
    }
    
    if (state.status == GameStatus.countdown) {
      nextLevel();
    }
  }

  void nextLevel() {
    final newPath = _sequenceGenerator.generateForLevel(state.currentLevel);
    _roundTotalTaps = 0;
    _roundCorrectTaps = 0;
    _roundStartTime = null;
    
    state = state.copyWith(
      status: GameStatus.showingPath,
      targetPath: newPath,
      userPath: [],
      clearFailedIndex: true,
    );
  }

  void retry() {
    _roundTotalTaps = 0;
    _roundCorrectTaps = 0;
    _roundStartTime = null;

    state = state.copyWith(
      status: GameStatus.showingPath,
      userPath: [],
      clearFailedIndex: true,
    );
  }

  void onDotTapped(int index) {
    if (state.status != GameStatus.waitingForInput) return;

    _roundStartTime ??= DateTime.now();
    
    _roundTotalTaps++;
    final newUserPath = [...state.userPath, index];
    final currentIndex = newUserPath.length - 1;

    AudioService.triggerHaptic();

    if (index == state.targetPath[currentIndex]) {
      _roundCorrectTaps++;
      
      if (newUserPath.length == state.targetPath.length) {
        AudioService.triggerSuccessHaptic();
        
        final elapsedMs = DateTime.now().difference(_roundStartTime!).inMilliseconds;
        final roundScore = Scorer.calculateRoundScore(
          pathLength: state.targetPath.length,
          correctTaps: _roundCorrectTaps,
          totalTaps: _roundTotalTaps,
          elapsedMs: elapsedMs,
        );
        
        state = state.copyWith(
          userPath: newUserPath,
          status: GameStatus.levelComplete,
          score: state.score + roundScore,
          currentLevel: state.currentLevel + 1,
        );
      } else {
        state = state.copyWith(userPath: newUserPath);
      }
    } else {
      AudioService.triggerErrorHaptic();
      final newLives = state.lives - 1;
      
      if (newLives <= 0) {
        state = state.copyWith(
          userPath: newUserPath,
          failedIndex: index,
          status: GameStatus.gameOver,
          lives: 0,
        );
        _finishGame();
      } else {
        state = state.copyWith(
          status: GameStatus.error,
          failedIndex: index,
          lives: newLives,
        );
      }
    }
  }

  void setInputWaiting() {
    state = state.copyWith(status: GameStatus.waitingForInput);
    _roundStartTime = DateTime.now();
  }

  Future<void> _finishGame() async {
    await _statsNotifier.updateGameResult(
      score: state.score,
      pathLength: state.targetPath.length,
      isSuccess: false,
      correctTaps: _roundCorrectTaps,
      totalTaps: _roundTotalTaps,
    );
  }
}

// Providers
final pathGeneratorProvider = Provider((ref) => PathGenerator());

final sequenceGeneratorProvider = Provider((ref) {
  return SequenceGenerator(ref.watch(pathGeneratorProvider));
});

class StatsNotifier extends StateNotifier<GameStats> {
  final StatsRepository _repository;

  StatsNotifier(this._repository) : super(_repository.getStats());

  Future<void> setPlayerName(String name) async {
    await _repository.setPlayerName(name);
    state = _repository.getStats();
  }

  Future<void> setTutorialSeen() async {
    await _repository.setTutorialSeen();
    state = _repository.getStats();
  }

  Future<void> updateGameResult({
    required int score,
    required int pathLength,
    required bool isSuccess,
    required int correctTaps,
    required int totalTaps,
  }) async {
    await _repository.updateGameResult(
      score: score,
      pathLength: pathLength,
      isSuccess: isSuccess,
      correctTaps: correctTaps,
      totalTaps: totalTaps,
    );
    state = _repository.getStats();
  }

  Future<void> resetStats() async {
    await _repository.resetStats();
    state = _repository.getStats();
  }
}

final statsRepositoryProvider = Provider((ref) {
  final box = Hive.box<GameStats>('stats');
  return StatsRepository(box);
});

final statsProvider = StateNotifierProvider<StatsNotifier, GameStats>((ref) {
  final repo = ref.watch(statsRepositoryProvider);
  return StatsNotifier(repo);
});

final gameStateProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final sequenceGen = ref.watch(sequenceGeneratorProvider);
  final statsNotifier = ref.watch(statsProvider.notifier);
  return GameNotifier(sequenceGen, statsNotifier);
});
