import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Custom painter to draw the glowing trace path between dots.
/// Calculates positions based on a 4x4 grid mathematical layout.
class PathPainter extends CustomPainter {
  final List<int> pathIndices;
  final Color pathColor;
  final double strokeWidth;
  final double glowIntensity;

  PathPainter({
    required this.pathIndices,
    this.pathColor = AppColors.pearlAqua,
    this.strokeWidth = 6.0,
    this.glowIntensity = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (pathIndices.length < 2) return;

    final double cellWidth = size.width / 4;
    final double cellHeight = size.height / 4;

    final paint = Paint()
      ..color = pathColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = pathColor.withValues(alpha: glowIntensity)
      ..strokeWidth = strokeWidth * 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final path = Path();

    for (int i = 0; i < pathIndices.length; i++) {
      final index = pathIndices[i];
      final int row = index ~/ 4;
      final int col = index % 4;

      final double x = (col + 0.5) * cellWidth;
      final double y = (row + 0.5) * cellHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Draw glow first, then solid core line over it
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.pathIndices != pathIndices ||
           oldDelegate.pathColor != pathColor ||
           oldDelegate.glowIntensity != glowIntensity;
  }
}
