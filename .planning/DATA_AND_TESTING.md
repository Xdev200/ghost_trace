# Data Model & Testing Strategy — GhostTrace

## 1. Data Model (Hive Models)
### GameStats (HiveObject)
```dart
@HiveType(typeId: 0)
class GameStats extends HiveObject {
  @HiveField(0)
  int totalScore;
  @HiveField(1)
  int bestRoundScore;
  @HiveField(2)
  int longestStreak;
  @HiveField(3)
  int bestPathLength;
  @HiveField(4)
  int totalGamesPlayed;
  @HiveField(5)
  int totalCorrectTaps;
  @HiveField(6)
  int totalTaps;
  @HiveField(7)
  DateTime? lastPlayedDate;
}
```

## 2. Testing Strategy
Targeting **90%+ test coverage** using `flutter_test`.

### Unit Tests
- **Scorer Logic**: Verify math for base, accuracy, and speed.
- **Sequence Generator**: Validate distance rules and length constraints.
- **Title Logic**: Check score ranges map to correct titles.
- **Stats Logic**: Daily bonus multiplier validation.

### Widget Tests
- **Grid Rendering**: Ensure 16 dots exist and are reachable.
- **Phase Transitions**: Verify UI changes from Memorize -> Trace -> Result.
- **CustomPainter**: Check if `shouldRepaint` triggers correctly.

### Integration Tests
- **Full Loop**: Play a round from Home to Result and verify Hive persistence.
- **Cold Start**: Handle Hive initialization and first-time user data creation.

### Automation
- Use `github actions` (optional) or local `flutter test` script.
- Repaint region checking during manual testing.
