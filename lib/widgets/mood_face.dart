import 'package:flutter/material.dart';

import '../core/theme/colors.dart';

class MoodFace extends StatelessWidget {
  final String faceType;
  final double size;
  final Color? backgroundColor;
  final Color? strokeColor;

  const MoodFace({
    super.key,
    required this.faceType,
    this.size = 48,
    this.backgroundColor,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors =
        AppColors.facePalette[faceType] ?? AppColors.facePalette['calm']!;
    final bg = backgroundColor ?? colors[0];
    final stroke = strokeColor ?? colors[1];

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MoodFacePainter(
          faceType: faceType,
          bgColor: bg,
          strokeColor: stroke,
        ),
      ),
    );
  }
}

class _MoodFacePainter extends CustomPainter {
  final String faceType;
  final Color bgColor;
  final Color strokeColor;

  _MoodFacePainter({
    required this.faceType,
    required this.bgColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 100.0;
    canvas.save();
    canvas.scale(scale, scale);

    // 1. Draw Organic Blob Shape
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final blobPath = _getBlobPath(faceType);
    canvas.drawPath(blobPath, bgPaint);

    // 2. Draw Facial Features
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    _drawFace(canvas, faceType, strokePaint, fillPaint);

    canvas.restore();
  }

  Path _getBlobPath(String type) {
    final path = Path();
    // Smooth blob normalized in 100x100 space
    switch (type) {
      case 'happy':
        path.moveTo(50, 6);
        path.cubicTo(76, 5, 94, 25, 94, 50);
        path.cubicTo(94, 75, 74, 94, 49, 94);
        path.cubicTo(24, 94, 6, 76, 6, 50);
        path.cubicTo(6, 25, 25, 7, 50, 6);
        break;
      case 'stressed':
      case 'anxious':
        path.moveTo(48, 7);
        path.cubicTo(80, 5, 95, 28, 92, 53);
        path.cubicTo(89, 78, 72, 95, 47, 92);
        path.cubicTo(22, 89, 6, 73, 8, 48);
        path.cubicTo(10, 23, 26, 9, 48, 7);
        break;
      case 'sad':
        path.moveTo(51, 8);
        path.cubicTo(77, 9, 92, 27, 91, 54);
        path.cubicTo(90, 80, 71, 93, 47, 93);
        path.cubicTo(23, 93, 8, 77, 8, 51);
        path.cubicTo(8, 25, 27, 7, 51, 8);
        break;
      default:
        path.addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 44));
        break;
    }
    return path;
  }

  void _drawFace(Canvas canvas, String type, Paint stroke, Paint fill) {
    switch (type) {
      case 'happy':
        // Smiling eyes
        final eyeLeft = Path()
          ..moveTo(33, 52)
          ..quadraticBezierTo(39, 43, 45, 52);
        final eyeRight = Path()
          ..moveTo(55, 52)
          ..quadraticBezierTo(61, 43, 67, 52);
        canvas.drawPath(eyeLeft, stroke);
        canvas.drawPath(eyeRight, stroke);

        // Big smile
        final mouth = Path()
          ..moveTo(38, 62)
          ..quadraticBezierTo(50, 78, 62, 62);
        canvas.drawPath(mouth, stroke);
        break;

      case 'calm':
        // Peaceful curved eyes
        final eyeLeft = Path()
          ..moveTo(33, 49)
          ..quadraticBezierTo(39, 55, 45, 49);
        final eyeRight = Path()
          ..moveTo(55, 49)
          ..quadraticBezierTo(61, 55, 67, 49);
        canvas.drawPath(eyeLeft, stroke);
        canvas.drawPath(eyeRight, stroke);

        // Gentle mouth
        final mouth = Path()
          ..moveTo(42, 63)
          ..quadraticBezierTo(50, 68, 58, 63);
        canvas.drawPath(mouth, stroke);
        break;

      case 'sad':
        // Dot eyes
        canvas.drawCircle(const Offset(38, 51), 3.2, fill);
        canvas.drawCircle(const Offset(62, 51), 3.2, fill);

        // Downward eyebrows
        canvas.drawLine(const Offset(31, 44), const Offset(44, 40), stroke);
        canvas.drawLine(const Offset(56, 40), const Offset(69, 44), stroke);

        // Frown mouth
        final mouth = Path()
          ..moveTo(40, 68)
          ..quadraticBezierTo(50, 59, 60, 68);
        canvas.drawPath(mouth, stroke);
        break;

      case 'angry':
        canvas.drawCircle(const Offset(39, 53), 3.2, fill);
        canvas.drawCircle(const Offset(61, 53), 3.2, fill);

        // Angled sharp brows
        canvas.drawLine(const Offset(31, 41), const Offset(44, 46), stroke);
        canvas.drawLine(const Offset(56, 46), const Offset(69, 41), stroke);

        // Flat mouth
        canvas.drawLine(const Offset(41, 67), const Offset(59, 67), stroke);
        break;

      case 'anxious':
        canvas.drawCircle(const Offset(38, 51), 3.8, fill);
        canvas.drawCircle(const Offset(62, 51), 3.8, fill);

        canvas.drawLine(const Offset(31, 41), const Offset(44, 37), stroke);
        canvas.drawLine(const Offset(56, 37), const Offset(69, 41), stroke);

        // Wobbly mouth
        final mouth = Path()
          ..moveTo(40, 66)
          ..quadraticBezierTo(45, 61, 50, 66)
          ..quadraticBezierTo(55, 71, 60, 66);
        canvas.drawPath(mouth, stroke);
        break;

      case 'stressed':
        // Stressed zigzag eyes
        final eyeL = Path()
          ..moveTo(33, 46)
          ..lineTo(43, 51)
          ..lineTo(33, 56);
        final eyeR = Path()
          ..moveTo(67, 46)
          ..lineTo(57, 51)
          ..lineTo(67, 56);
        canvas.drawPath(eyeL, stroke);
        canvas.drawPath(eyeR, stroke);

        // Wavy mouth
        final mouth = Path()
          ..moveTo(39, 67)
          ..quadraticBezierTo(45, 62, 50, 67)
          ..quadraticBezierTo(55, 72, 60, 67);
        canvas.drawPath(mouth, stroke);
        break;

      case 'ashamed':
        canvas.drawCircle(const Offset(39, 54), 3.2, fill);
        canvas.drawCircle(const Offset(61, 54), 3.2, fill);

        // Cheeks blush
        final blushPaint = Paint()
          ..color = strokeColor.withValues(alpha: 0.28)
          ..style = PaintingStyle.fill;
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(30, 61), width: 10, height: 6),
          blushPaint,
        );
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(70, 61), width: 10, height: 6),
          blushPaint,
        );

        final mouth = Path()
          ..moveTo(44, 68)
          ..quadraticBezierTo(50, 65, 56, 69);
        canvas.drawPath(mouth, stroke);
        break;

      case 'tired':
        // Half closed flat eyes
        canvas.drawLine(const Offset(33, 50), const Offset(45, 50), stroke);
        canvas.drawLine(const Offset(55, 50), const Offset(67, 50), stroke);

        // Eye bags
        final bagL = Path()
          ..moveTo(36, 56)
          ..quadraticBezierTo(39, 59, 42, 56);
        final bagR = Path()
          ..moveTo(58, 56)
          ..quadraticBezierTo(61, 59, 64, 56);
        canvas.drawPath(bagL, stroke);
        canvas.drawPath(bagR, stroke);

        canvas.drawLine(const Offset(44, 67), const Offset(56, 67), stroke);
        break;

      default:
        canvas.drawCircle(const Offset(38, 52), 3.2, fill);
        canvas.drawCircle(const Offset(62, 52), 3.2, fill);
        canvas.drawLine(const Offset(42, 65), const Offset(58, 65), stroke);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _MoodFacePainter oldDelegate) {
    return oldDelegate.faceType != faceType ||
        oldDelegate.bgColor != bgColor ||
        oldDelegate.strokeColor != strokeColor;
  }
}
