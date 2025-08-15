import 'package:flutter/material.dart';
import 'dart:math';

class SpatterPainter extends CustomPainter {
  final Random _random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.85);

    for (int i = 0; i < 100; i++) {
      double x = size.width * (0.6 + _random.nextDouble() * 0.4);
      double y = size.height * _random.nextDouble();
      double radius = _random.nextDouble() * 3 + 1;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
