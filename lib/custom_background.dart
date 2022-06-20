import 'package:flutter/material.dart';
import '/app_properties.dart';

class MainBackground extends CustomPainter {
  MainBackground();
  /*
  Canvas Called whenever the object needs to paint. The given [Canvas] has its 
  coordinate space configured such that the origin is at the top left of 
  the box. The area of the box is the size of the [size] argument.
  */
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    //Drawing Rectangle on Screen
    //Firstly White on Entire Screen
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = Colors.white);
    // Then Red on One Third From Left Transparent Red
    canvas.drawRect(Rect.fromLTRB(width - (width / 3), 0, width, height),
        Paint()..color = transparentRed);
    //Construct a rectangle from its left, top, right, and bottom edges.
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
