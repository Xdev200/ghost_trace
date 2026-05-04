# Technology & Design Strategy — GhostTrace

## Technology Stack Validation
| Technology | Choice | Rationale | Alternatives |
|------------|--------|-----------|--------------|
| **Framework** | Flutter | High-performance graphics (CustomPainter), smooth 60fps animations, fast iteration. | React Native (lower graphics perf for heavy neon effects). |
| **State Management** | Riverpod | Compile-safe, no boilerplate, excellent for global state (Stats) and local state (Game). | BLoC (more boilerplate), Provider (less flexible). |
| **Database** | Hive | Extremely fast NoSQL storage, native performance, low overhead for small objects. | SQLite (heavyweight for stats), SharedPreferences (limited types). |
| **Animation** | flutter_animate | Declarative, easy to chain, perfect for neon pulses and screen transitions. | Manual AnimationControllers (verbose). |
| **Audio** | AudioPlayers | Reliable playback of short tones and long-running tracks. | flutter_sound (more complex than needed). |

## Design Patterns
1. **Repository Pattern**: Abstracting Hive/SP to allow switching storage engines without touching business logic.
2. **Strategy Pattern**: For sequence generation (could have different strategies for difficulty levels).
3. **Observer Pattern**: Riverpod's core mechanism for UI updates.
4. **Singleton Pattern**: For AudioService to ensure single instance management of hardware resources.
5. **Factory Pattern**: For creating different `GameState` transitions.

## Code Structure Plan
```text
lib/
  main.dart                  # Entry point & Initializers
  app.dart                   # Material App & Routing
  theme/
    colors.dart              # Neon palette
    text_styles.dart         # Orbitron/ShareTech
    effects.dart             # BoxShadow/Glow utilities
  models/
    game_stats.dart          # Hive model
    game_state.dart          # Immutable state model
  providers/
    game_provider.dart       # Main game orchestrator
    stats_provider.dart      # Persistence layer
  logic/
    sequence_generator.dart  # Path generation
    scorer.dart              # Score calculation
  services/
    audio_service.dart       # Tone generation
    haptic_service.dart      # Feedback
  screens/
    home/
    game/
    result/
  widgets/
    common/                  # NeonButton, GlassCard
    game/                    # DotGrid, PathPainter
    overlay/                 # ScanlineOverlay
  constants/
    game_config.dart         # Tunables
    titles.dart              # Score-to-Title mapping
```

## Reusable Component Strategy
- **`NeonContainer`**: Base widget for adding layered shadows and borders.
- **`GlowText`**: Helper for Orbitron text with shadow.
- **`BaseScreen`**: Wrapper with `ScanlineOverlay` and `Theme` consistency.
- **`AsyncHandler`**: Utility for safe Hive operations.
