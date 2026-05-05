import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/effects.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/landing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppEffects.skyGradient(),
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.coolSky.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.coolSky, width: 4),
                boxShadow: AppEffects.glowShadow(AppColors.coolSky, intensity: 0.6, blur: 30),
              ),
              child: const Center(
                child: Text(
                  'GT',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.coolSky,
                    fontFamily: 'Orbitron',
                  ),
                ),
              ),
            )
                .animate()
                .scale(duration: 800.ms, curve: Curves.easeOutBack)
                .shimmer(delay: 1.seconds, duration: 1200.ms),
            const SizedBox(height: 40),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'GHOST TRACER',
                style: AppTextStyles.heading.copyWith(fontSize: 24, letterSpacing: 4),
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 800.ms)
                .slideY(begin: 0.5, end: 0),
          ],
        ),
        ),
      ),
    );
  }
}
