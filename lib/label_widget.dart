import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  final Color color;
  final Offset from;
  final double radius;
  DrawCircle(this.color, this.from, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    canvas.drawCircle(from, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class Label extends StatelessWidget {
  final String _label;
  final Color _color;
  Label(this._label, this._color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 25),
        Text(_label, style: TextStyle(fontSize: 13)),
        Container(
          width: 15,
          height: 10,
          child: CustomPaint(
            size: Size(100, 100),
            painter: DrawCircle(_color, Offset(3, -2), 3,),
          ),
          padding: EdgeInsets.all(8),
          // Enable for debugging
          // decoration: BoxDecoration(border: Border.all(color: _color)),
        ),
      ],
    );
  }
}
