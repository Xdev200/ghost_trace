# 🎮 GhostTrace — Enhanced Flutter Native App PRD

## Visual Identity
Dark neon cyberpunk theme throughout:
* **Background**: Deep `#050508` near-black
* **Primary glow**: Cyan `#00FFE5`
* **Secondary glow**: Magenta `#FF00C8`
* **Accent**: Purple `#9B30FF` and Lime `#BFFF00`
* **Fonts**: Google Fonts - `Orbitron` (headings/scores), `Share Tech Mono` (stats/labels)
* **Neon glow effect**: `BoxDecoration` with layered `BoxShadow` (5, 15, 30px)
* **All screens**: Animated scanline overlay (CRT feel)

## Core Gameplay Loop
**Grid**: 4×4 dot grid (16 dots, 72px target, 16px gap)

**Round flow:**
1. **Show Phase**: Glowing path sequence animation.
2. **Fade Phase**: Transition to ghost trails (600ms).
3. **Trace Phase**: Player taps dots in order. Correct = pulse + beep. Wrong = flash + buzzer + end.
4. **Score Phase**: Round summary and score reveal.

**Sequence generation rules:**
* Start: length 3, 2.5s duration, 400ms delay.
* Success progression: length +1 (cap 12) every 3 wins, duration -100ms (floor 800ms).
* Path length 8+: Simultaneous show (1.2s total).
* Randomize with min Euclidean distance 1.5 units.

## Progression System
**Titles:**
* 0–199: Ghost Novice
* 200–499: Neon Tracer
* 500–999: Phantom Coder
* 1000–1999: Signal Ghost
* 2000–4999: Neon Phantom
* 5000+: VOID WALKER

**Scoring:**
* base_score = path_length × 100
* accuracy_multiplier = (correct_taps / total_taps) × 2.0
* speed_bonus = max(0, 500 − elapsed_ms_for_trace / path_length)
* round_score = (base_score × accuracy_multiplier) + speed_bonus

**Persistent Stats (Hive):**
* totalScore, bestRoundScore, longestStreak, currentStreak, bestPathLength, totalGamesPlayed, totalCorrectTaps, totalTaps, lastPlayedDate (1.5x bonus for daily play).

## Screens
### 🏠 Home Screen
* App name "GHOSTTRACE"
* Player title
* Score card (glassmorphism)
* Stats row
* Daily bonus badge
* TRACE button
* HOW TO PLAY link

### 🎮 Game Screen
* Top bar: score and streak
* Phase label: MEMORIZE -> GHOST -> TRACE
* 4x4 Grid
* Path lines
* Progress bar (time remaining)

### 📊 End Screen
* Result (PATH TRACED / SIGNAL LOST)
* Count-up score animation
* Breakdown
* New records highlight
* Confetti on new PB
* NEXT PATH / HOME buttons

## Audio
* Tone generation (sine waves)
* Correct: 880Hz, 80ms
* Wrong: 440->220Hz, 300ms
* Success: C5-E5-G5 chime
* Fanfare for PB
* Mute toggle

## Technical Spec
* Flutter Native
* State Management: Riverpod
* Storage: Hive + SharedPreferences
* UI: Google Fonts, flutter_animate, confetti, audioplayers
* Performance: CustomPainter, RepaintBoundary, Lock portrait.
