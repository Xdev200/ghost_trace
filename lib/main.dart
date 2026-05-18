import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/game_stats.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(GameStatsAdapter());
  await Hive.openBox<GameStats>('stats');
  
  runApp(
    const ProviderScope(
      child: GhostTracerApp(),
    ),
  );
}
