# 🎮 GhostTracer — Space-Themed Memory Game

GhostTracer is a premium, high-performance Flutter memory game with a sleek "Space & Sky" aesthetic. Memorize the glowing paths, navigate the ghost trails, and trace the sequence perfectly to climb the ranks.

---

## 🚀 Execution Guide

### 1. Prerequisites
Before running the project, ensure you have:
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured.
*   Run `flutter doctor` to verify your environment.
*   Run `flutter pub get` in the project root to install dependencies.

---

### 🌐 Running on Web
To run GhostTracer in your browser (Chrome is recommended):

1.  **Enable Web Support** (if not already done):
    ```bash
    flutter config --enable-web
    ```
2.  **Launch the App**:
    ```bash
    flutter run -d chrome
    ```

---

### 🏗 Build & Deployment

This project uses a unified build system to manage both the **Flutter App** and the **Info Website**.

#### 1. Build the Entire Suite
From the `ghost_tracer` root, run:
```bash
npm run build
```
*This will build the Flutter Web app into `build/web` and the Info Website into `../ghost_tracer_web/dist`.*

#### 2. Build Separately
- **Flutter Game Only**: `npm run build:app`
- **Info Website Only**: `npm run build:web`

#### 3. Deploy to Vercel
Refer to the [Vercel Deployment Guide](./deployment_guide.md) for step-by-step instructions on connecting your repository.

---

---

### 📱 Running on a Physical Device
To run on a physical Android or iOS device via the development server:

#### **Step A: Prepare Your Device**
*   **Android**: Enable **USB Debugging** in Developer Options.
*   **iOS**: Ensure the device is trusted and **Developer Mode** is on (iOS 16+).
*   Connect the device to your computer via USB.

#### **Step B: Identify Your Device**
List all connected devices to find your Device ID:
```bash
flutter devices
```

#### **Step C: Launch the App**
Run the app on your specific device using its ID (replace `<DEVICE_ID>`):
```bash
flutter run -d <DEVICE_ID>
```
*   *Tip: If only one device is connected, you can simply run `flutter run`.*

#### **Step D: Development Server Features**
Once the app is running, use these terminal commands for a fast workflow:
*   `r`: **Hot Reload** (Updates code changes instantly).
*   `R`: **Hot Restart** (Restarts the app state).
*   `h`: List all available interactive commands.

---

## 🛠 Tech Stack
*   **Core**: Flutter Native
*   **State Management**: Riverpod
*   **Local Storage**: Hive (Stats) & SharedPreferences (Settings)
*   **Animations**: `flutter_animate`
*   **Theming**: Custom "Space & Sky" Design System

---

## 📝 Design & Features
*   **Visual Feedback**: Green shadows for correct taps, Red for errors.
*   **Progression**: 6 unique player titles based on performance.
*   **Haptics**: Tactile feedback for every interaction.
*   **Responsive**: Optimized for both mobile and web layouts.
