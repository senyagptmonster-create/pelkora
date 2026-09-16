import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/pelkora_theme.dart';

class ReservoirLevelPainter extends CustomPainter {
  final double fillPercentage; // 0.0 to 1.0 (water level)
  final double currentLiters;

  ReservoirLevelPainter({
    required this.fillPercentage,
    required this.currentLiters,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Outer clear planter reservoir beaker
    final reservoirRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.22, h * 0.12, w * 0.56, h * 0.76),
      const Radius.circular(18),
    );
    final bgPaint = Paint()
      ..color = PelkoraTheme.edge.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(reservoirRect, bgPaint);

    final borderPaint = Paint()
      ..color = PelkoraTheme.edge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawRRect(reservoirRect, borderPaint);

    // Water fill body
    final clampedFill = fillPercentage.clamp(0.05, 1.0);
    final waterH = (h * 0.76) * clampedFill;
    final waterTop = (h * 0.12) + (h * 0.76) - waterH;

    final waterPath = Path();
    waterPath.moveTo(w * 0.22, waterTop);

    // Gentle surface wave
    final waveW = w * 0.56;
    for (double x = 0; x <= waveW; x += 4) {
      final yOffset = sin((x / waveW) * pi * 3) * 3;
      waterPath.lineTo(w * 0.22 + x, waterTop + yOffset);
    }
    waterPath.lineTo(w * 0.78, (h * 0.12) + (h * 0.76));
    waterPath.lineTo(w * 0.22, (h * 0.12) + (h * 0.76));
    waterPath.close();

    final waterPaint = Paint()
      ..color = PelkoraTheme.accent.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    canvas.drawPath(waterPath, waterPaint);

    // Float indicator stem and bulb
    final floatX = w * 0.68;
    final floatStem = Paint()
      ..color = Colors.orangeAccent
      ..strokeWidth = 2.5;
    canvas.drawLine(Offset(floatX, waterTop - 18), Offset(floatX, (h * 0.12) + (h * 0.76) - 10), floatStem);

    final bulbPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(floatX, waterTop), 7.0, bulbPaint);

    // Graduated tick marks on the left
    final tickPaint = Paint()
      ..color = PelkoraTheme.muted
      ..strokeWidth = 1.5;
    for (int i = 1; i <= 4; i++) {
      final tickY = (h * 0.12) + (h * 0.76) * (i / 5.0);
      canvas.drawLine(Offset(w * 0.22, tickY), Offset(w * 0.28, tickY), tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ReservoirLevelPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.currentLiters != currentLiters;
  }
}
