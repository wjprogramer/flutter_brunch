import 'package:flutter/material.dart';

/// 傳入 [CustomPainter]
class CustomPaintContainer extends StatelessWidget {
  final CustomPainter painter;
  final Widget child;

  CustomPaintContainer({
    @required this.painter,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: painter,
          child: child,
        ),
      ),
    );
  }
}

typedef CanvasPaint = void Function(Canvas canvas, Size size);

/// 傳入繪畫函數 [CanvasPaint]
class CustomPaintContainer2 extends StatelessWidget {
  final Widget child;
  final CanvasPaint canvasPaint;
  final double height;
  final double width;
  final Color color;

  CustomPaintContainer2({
    @required this.canvasPaint,
    this.child,
    this.height = 200,
    this.width = 200,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        color: color ?? Colors.grey,
        child: CustomPaint(
          painter: _Painter(canvasPaint),
          child: child,
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final CanvasPaint canvasPaint;

  _Painter(this.canvasPaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvasPaint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

}
