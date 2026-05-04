# GhostTrace

## What This Is
A minimalistic, production-ready memory and tracing game for mobile. Players must memorize a glowing neon path on a 4x4 grid and trace it back with accuracy and speed in a high-contrast cyberpunk environment.

## Core Value
Delivering a visually stunning and mechanically addictive memory challenge that feels premium and responsive.

## Requirements

### Validated
(None yet — ship to validate)

### Active
- [ ] **Infrastructure**: Flutter project init, Hive storage, Riverpod state.
- [ ] **Visual Identity**: Neon theme, custom fonts, scanline overlay.
- [ ] **Core Loop**: Procedural sequence generation and phase orchestration.
- [ ] **Game Mechanics**: Grid interaction, path painting, real-time feedback.
- [ ] **Progression**: Scoring engine, title system, persistent stats.
- [ ] **Audio/Haptics**: Tone generation and vibration feedback.

### Out of Scope
- **Online Multiplayer**: Keeping it fully offline first for simplicity and speed.
- **Microtransactions**: Purely skill-based progression.
- **Customizable Grids**: Fixed 4x4 for optimal mobile touch targets.

## Context
- High emphasis on "wow" factor aesthetics.
- Targeted at casual players who enjoy short, intense memory sessions.
- Built for native mobile performance using Flutter's high-level graphics APIs.

## Constraints
- **Tech Stack**: Flutter, Riverpod, Hive.
- **Performance**: Must maintain 60fps on mid-range devices.
- **Orientation**: Locked to portrait.

## Key Decisions
| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Riverpod | Better state isolation and testability than Provider. | — Pending |
| Hive | Native NoSQL performance for small, frequent writes. | — Pending |
| CustomPainter | Necessary for high-performance neon line drawing. | — Pending |

## Evolution
This document evolves at phase transitions and milestone boundaries.

---
*Last updated: 2024-05-04 after initialization*
