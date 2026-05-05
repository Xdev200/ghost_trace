import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/common/neon_button.dart';
import '../theme/effects.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppEffects.skyGradient(),
        ),
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                'WELCOME TO',
                style: AppTextStyles.subHeading.copyWith(color: AppColors.white),
              ).animate().fadeIn(duration: 600.ms),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'GHOST TRACER',
                  style: AppTextStyles.heading.copyWith(fontSize: 28, letterSpacing: 4),
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
              const SizedBox(height: 60),
              _buildGuideItem(
                index: 1,
                title: 'MEMORIZE',
                description: 'Watch the path illuminate on the grid. Remember the sequence carefully.',
                icon: Icons.visibility_rounded,
                color: AppColors.coolSky,
              ),
              const SizedBox(height: 32),
              _buildGuideItem(
                index: 2,
                title: 'GHOST',
                description: 'The path fades into ghosts. Use your memory to visualize the trail.',
                icon: Icons.blur_on_rounded,
                color: AppColors.jasmine,
              ),
              const SizedBox(height: 32),
              _buildGuideItem(
                index: 3,
                title: 'TRACE',
                description: 'Tap the dots in order. Speed and accuracy boost your score!',
                icon: Icons.touch_app_rounded,
                color: AppColors.pearlAqua,
              ),
              const Spacer(),
              NeonButton(
                text: 'START TRACING',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ).animate().slideY(begin: 1, end: 0, delay: 1200.ms).fadeIn(),
              const SizedBox(height: 40),
            ],
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuideItem({
    required int index,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
            boxShadow: AppEffects.glowShadow(color, intensity: 0.2, blur: 10),
          ),
          child: Icon(icon, color: color, size: 24),
        ).animate().scale(delay: (index * 200).ms, duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.subHeading.copyWith(color: color, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.body.copyWith(color: AppColors.powderBlue, height: 1.4),
              ),
            ],
          ).animate().fadeIn(delay: (index * 200 + 200).ms, duration: 600.ms),
        ),
      ],
    );
  }
}
