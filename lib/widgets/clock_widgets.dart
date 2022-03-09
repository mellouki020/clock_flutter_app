import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_app/ui/style.dart';
import 'package:flutter_clock_app/utils/time_model.dart';

class ClockWidgets extends StatefulWidget {
   ClockWidgets(this.time,{Key? key}) : super(key: key);
  TimeModel time;

  @override
  _ClockWidgetsState createState() => _ClockWidgetsState();
}

class _ClockWidgetsState extends State<ClockWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //add some effects
        boxShadow: [
          BoxShadow(color: AppStyle.primaryColor.withAlpha(80), blurRadius: 38.0),
        ]

      ),
      height: 300.0,
      width: 300.0,
      child: CustomPaint(
        painter: ClockPainter(widget.time),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{

  //let's set the time parameter
  TimeModel? time;
  ClockPainter(this.time);
  @override
  void paint(Canvas canvas, Size size) {
  //let's calculate the time possition
    double secRad = ((pi/2) - (pi/30) * this.time!.sec!) % (2 * pi);
    double minRad = ((pi/2) - (pi/30) * this.time!.min!) % (2 * pi);
    double hourRad = ((pi/2) - (pi/6) * this.time!.hour!) % (2 * pi);

    var centerX = size.width / 2; // ignore: unused_local_variable
    var centerY = size.height / 2;
    var center = Offset(centerY, centerX);
    var radius = min(centerX, centerY);

    //setting the clock coordinate
    var secHeight = radius / 2;
    var minHeight = radius / 2 - 10;
    var hourHeight = radius / 2 - 25;

    var seconds = Offset(
        centerX + secHeight * cos(secRad), centerY - secHeight * sin(secRad));
    var mintues = Offset(
        centerX + minHeight * cos(minRad), centerY - minHeight * sin(minRad));
    var hours = Offset(
        centerY + hourHeight * cos(hourRad), centerY - hourHeight * sin(hourRad));

    //setting the Brush
    var fillBrush = Paint()
    ..color = AppStyle.primaryColor
    ..strokeCap = StrokeCap.round;

    var centerDotBrush = Paint()..color = Color(0xFFEAECFF);

    //setting the hnad brush
    var secBrush = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2
    ..strokeJoin  = StrokeJoin.round;
    var minBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin  = StrokeJoin.round;

    var hourBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..strokeJoin  = StrokeJoin.round;
    //drawing th body
    canvas.drawCircle(center, radius - 40, fillBrush);
    //drawing the clock hands
    canvas.drawLine(center, seconds, secBrush);
    canvas.drawLine(center, mintues, minBrush);
    canvas.drawLine(center, hours, hourBrush);
    //drawing ther center dot
    canvas.drawCircle(center, 16, centerDotBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}