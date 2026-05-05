import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  
  Future<void> playSound(String assetPath) async {
    // Note: Assuming assets are defined in pubspec.yaml
    // For now, we wrap in try-catch to avoid crashes if assets missing
    try {
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      // Silently fail if asset not found
    }
  }

  static Future<void> triggerHaptic() async {
    await HapticFeedback.mediumImpact();
  }
  
  static Future<void> triggerSuccessHaptic() async {
    await HapticFeedback.lightImpact();
  }

  static Future<void> triggerErrorHaptic() async {
    await HapticFeedback.heavyImpact();
  }
}
