import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgressbarWithAnimation extends StatelessWidget {
  final double stroke;
  final double? innerStroke;
  final double from;
  final double to;
  final Color innerStrokeColor;
  final Color strokeColor;
  final List<CircularProgressWithAnimationColor>? innerStrokeColorList;
  final List<CircularProgressWithAnimationColor>? strokeColorList;
  final String symbol;
  final TextStyle? textStyle;

  const CircularProgressbarWithAnimation(
      {Key? key,
      this.stroke = 10,
      this.innerStroke,
      this.from = 0,
      this.to = 1,
      this.strokeColor = Colors.grey,
      this.innerStrokeColor = Colors.blue,
      this.symbol = '%',
      this.textStyle,
      this.innerStrokeColorList,
      this.strokeColorList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double radius = constraints.maxWidth / 2 - 10;
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: _main(radius),
      );
    });
  }

  Widget _main(double radius) => Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
              painter: PaintMainCircle(
                  color: strokeColor, radius: radius, stroke: stroke)),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: from, end: to),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              builder: (context, double index, widget) => Stack(
                    alignment: Alignment.center,
                    children: [
                      _customPaint(radius, index),
                      FittedBox(
                        child: Text(
                          '${(index * 100).toInt()}$symbol',
                          style: _getTextStyle(index),
                        ),
                      )
                    ],
                  ))
        ],
      );

  Widget _customPaint(radius, index) => CustomPaint(
      painter: PaintInnerCircle(
          color: innerStrokeColorList != null
              ? _findColorFromList(index)
              : innerStrokeColor,
          radius: radius * 2,
          stroke: innerStroke ?? stroke / 2,
          from: from,
          to: index));

  TextStyle _getTextStyle(index) {
    final list = _getColors(index);
    return list.isNotEmpty
        ? (textStyle ?? const TextStyle(fontSize: 18))
            .copyWith(color: list.first.color)
        : (textStyle ?? const TextStyle(fontSize: 18));
  }

  Color _findColorFromList(double index) {
    final list = _getColors(index);
    return list.isNotEmpty ? list.first.color : innerStrokeColor;
  }

  List<CircularProgressWithAnimationColor> _getColors(index) {
    return innerStrokeColorList!.where((element) {
      final double tempIndex = index >= 0.99 ? 1 : index;
      switch (element.operator) {
        case CircularProgressAnimColorOperator.isEqual:
          return element.index == tempIndex;
        case CircularProgressAnimColorOperator.isGrather:
          return element.index < tempIndex;
        case CircularProgressAnimColorOperator.isLower:
          return element.index > tempIndex;
        case CircularProgressAnimColorOperator.isGratherAndEqual:
          return element.index <= tempIndex;
        case CircularProgressAnimColorOperator.isLowerAndEqual:
          return element.index >= tempIndex;
        default:
          return element.index == index;
      }
    }).toList()
      ..sort((a, b) => a.index.compareTo(b.index));
  }
}

class CircularProgressWithAnimationColor {
  final double index;
  final Color color;
  final CircularProgressAnimColorOperator operator;

  CircularProgressWithAnimationColor(
      {required this.color,
      required this.index,
      this.operator = CircularProgressAnimColorOperator.isEqual});
}

enum CircularProgressAnimColorOperator {
  isEqual,
  isGrather,
  isLower,
  isGratherAndEqual,
  isLowerAndEqual
}

// Painter classes

class PaintMainCircle extends CustomPainter {
  final double radius;
  final double stroke;
  final Color color;

  PaintMainCircle(
      {required this.radius, required this.stroke, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(const Offset(0, 0), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PaintInnerCircle extends CustomPainter {
  final double radius;
  final double stroke;
  final double from;
  final double to;
  final Color color;

  PaintInnerCircle(
      {required this.radius,
      required this.from,
      required this.to,
      required this.stroke,
      required this.color});

  double degToRad(double deg) => deg * (math.pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    // canvas.drawCircle(offset ?? const Offset(100, 100), 100, paint);
    final path = Path();
    path.arcTo(
        Rect.fromCenter(
            center: const Offset(0, 0), width: radius, height: radius),
        degToRad(360 * from),
        degToRad(360 * (to == 1 ? 0.9999 : to)),
        false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
