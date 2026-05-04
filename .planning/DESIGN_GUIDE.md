# UI/UX Design Guide — GhostTrace

## 1. Visual Language: Dark Neon Cyberpunk
- **Contrast**: High contrast between near-black background and vibrant neon accents.
- **Depth**: Use of "layered glow" (box-shadow stacks) instead of traditional elevations.
- **Materiality**: Glassmorphism (blur + semi-transparent overlays).

## 2. Design Tokens
### Colors
- **BG**: `#050508`
- **Primary (Cyan)**: `#00FFE5` (Glow: 5, 15, 30px)
- **Secondary (Magenta)**: `#FF00C8`
- **Accent (Purple)**: `#9B30FF`
- **Accent (Lime)**: `#BFFF00`
- **Error (Red)**: `#FF2D2D`

### Typography
- **Headings**: `Orbitron` (Cyan/Magenta glow, wide letter spacing).
- **Body/Stats**: `Share Tech Mono` (Clean, tech-focused).

### Interaction Patterns
- **Correct Tap**: Cyan pulse + light haptic.
- **Incorrect Tap**: Red flash + heavy haptic.
- **Buttons**: Cyan background with black text (heavy glow on idle).

## 3. Screen Designs
### Home Screen
- Center-aligned layout.
- Glassmorphic "Score Card" showing PB and "World Record".
- Pulse animation on main "TRACE" button.

### Game Screen
- Top-anchored score/streak.
- Central 4x4 Grid (60% height).
- Real-time magenta trail building as user taps.
- Scanning CRT lines overlay at low opacity.

### Result Screen
- Dynamic count-up animation for score.
- Confetti burst on New Personal Best.
- Transparent "HOME" button vs Solid "NEXT" button.

## 4. Accessibility
- Minimum touch targets: 72px for grid dots.
- Color redundancy: Tones and haptics accompany visual cues.
- High contrast: WCAG compliant contrast for all text.
