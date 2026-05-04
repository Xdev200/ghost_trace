# System Architecture Design — GhostTrace

## High-Level Architecture
GhostTrace follows **Clean Architecture** principles, separated into three main layers:

### 1. Presentation Layer (UI & State)
- **Widgets**: Reusable UI components (NeonButton, DotGrid, etc.).
- **Screens**: Main page compositions (HomeScreen, GameScreen, ResultScreen).
- **Providers (Riverpod)**: Management of UI state (GameState, Timer, Score).
- **Controllers**: Logic for UI-specific behaviors (e.g., GridController for animations).

### 2. Domain Layer (Business Logic)
- **Models**: Immutable data structures (GameStateModel, GameStats).
- **Services**: Pure business logic (Scorer, SequenceGenerator).
- **Repositories (Interfaces)**: Definitions for data persistence.

### 3. Data Layer (Infrastructure)
- **Repositories (Implementation)**: Hive and SharedPreferences logic.
- **Adapters**: Hive TypeAdapters for model serialization.
- **Hardware Services**: Haptics and Audio (AudioPlayers wrapper).

## Module Boundaries
- `logic/`: Pure Dart, no Flutter dependencies (Scorer, SequenceGenerator).
- `theme/`: Styling tokens (Colors, TextStyles).
- `widgets/`: Independent UI components.
- `screens/`: Feature-specific orchestrators.

## Data Flow
1. **User Action**: Tap dot.
2. **Controller/Provider**: Receives tap, validates against current sequence.
3. **Logic Service**: Calculates score/progression if round ends.
4. **Data Layer**: Persists stats if record broken.
5. **UI**: Updates glow, trail, and labels via state notification.

## Dependency Graph
- Screens -> Providers -> Logic Services
- Providers -> Repositories -> Data Sources (Hive/SP)
- Widgets -> Theme
