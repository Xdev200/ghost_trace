# REQUIREMENTS.md — GhostTrace

## Milestone 1: Core Engine & Aesthetics
Focused on getting the game loop and the "premium" feel right.

### R1: Technical Foundation
- [ ] Initialize Flutter project.
- [ ] Configure Hive for `GameStats` and SharedPreferences for settings.
- [ ] Set up Riverpod for state management.
- [ ] Set up Google Fonts (Orbitron, Share Tech Mono).

### R2: Neon UI Kit
- [ ] Create `NeonButton` with layered shadows.
- [ ] Implement `GlassCard` with BackdropFilter.
- [ ] Create `ScanlineOverlay` custom painter.
- [ ] Define global theme with cyberpunk palette.

### R3: Gameplay Core
- [ ] Implement 4x4 `DotGrid`.
- [ ] Create `SequenceGenerator` with min-distance logic.
- [ ] Implement `PathPainter` for neon trails and ghost lines.
- [ ] Manage Game Phases (Show, Fade, Trace, Score).

### R4: Progression & Polish
- [ ] Implement `Scorer` with accuracy/speed multipliers.
- [ ] Build Home, Game, and Result screens.
- [ ] Add Tone Generation and Haptic Feedback.
- [ ] Implement Confetti and Record highlighting.

## Acceptance Criteria (UAT)
- [ ] Path tracing feels instantaneous (no lag).
- [ ] Neon glow is visible and vibrant on various screens.
- [ ] Stats persist correctly across app restarts.
- [ ] Wrong tap triggers immediate failure feedback.
- [ ] 90%+ test coverage on core logic.
