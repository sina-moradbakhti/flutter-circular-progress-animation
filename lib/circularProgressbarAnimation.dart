import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgressbarWithAnimation extends StatelessWidget {
  final double from;
  final double to;
  final double strokeWidth;
  final double innerStrokeWidth;
  final Color strokeColor;
  final Color innerStrokeColor;
  final String symbol;
  final Duration? duration;
  final List<ColorRule>? colorConditions;

  CircularProgressbarWithAnimation(
      {Key? key,
      this.from = 0,
      this.to = 100,
      this.symbol = '%',
      this.colorConditions,
      this.strokeColor = Colors.grey,
      this.innerStrokeColor = Colors.purpleAccent,
      this.innerStrokeWidth = 15,
      this.strokeWidth = 5,
      this.duration})
      : super(key: key);

  double _from = 0;
  double _to = 0;

  @override
  Widget build(BuildContext context) {
    _from = from / 100;
    _to = to / 100;

    return LayoutBuilder(builder: ((context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
                painter: CirclePainter(
                    radius: (constraints.maxWidth / 2) - 10,
                    strokeWidth: strokeWidth,
                    color: strokeColor)),
            TweenAnimationBuilder(
                tween: Tween<double>(begin: _from, end: _to),
                curve: Curves.easeInOut,
                duration: duration ?? const Duration(seconds: 1),
                builder: (context, double index, widget) => Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                            painter: ArcPainter(
                                from: _from,
                                to: index,
                                radius: (constraints.maxWidth / 2) - 10,
                                strokeWidth: innerStrokeWidth,
                                color: _getConditionalColor(index * 100) ??
                                    innerStrokeColor)),
                        Text(
                          '${(index * 100).toInt()}$symbol',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: _getConditionalColor(index * 100) ??
                                  innerStrokeColor),
                        )
                      ],
                    )),
          ],
        ),
      );
    }));
  } // build

  Color? _getConditionalColor(double index) {
    if (colorConditions == null) {
      return null;
    } else {
      final double tempIndex = (index / 100) >= 0.99 ? 100 : index;
      final rules = colorConditions!
          .where((rule) => (tempIndex >= rule.rangeIndex[0] &&
              tempIndex <= rule.rangeIndex[1]))
          .toList();
      if (rules.isEmpty) return null;
      return rules.first.color;
    }
  }
}

// Custom Painter classes

class CirclePainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Color color;

  CirclePainter(
      {required this.radius, required this.strokeWidth, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(const Offset(0, 0), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ArcPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Color color;
  final double from;
  final double to;

  ArcPainter(
      {required this.from,
      required this.to,
      required this.radius,
      required this.strokeWidth,
      required this.color});

  double degToRad(double deg) => deg * (math.pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
        Rect.fromCenter(
            center: const Offset(0, 0), width: radius * 2, height: radius * 2),
        degToRad(from * 360),
        degToRad((to >= 1 ? 0.99 : to) * 360),
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Condition class

class ColorRule {
  final List<double> rangeIndex;
  final Color color;
  ColorRule({required this.color, required this.rangeIndex});
}
