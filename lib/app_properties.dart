import 'package:flutter/material.dart';

const Color red = Color.fromARGB(255, 199, 26, 26);
const Color mediumRed = Color.fromARGB(255, 253, 70, 70);
const Color darkRed = Color.fromARGB(255, 233, 34, 34);

// Used for Background Color
const Color transparentRed = Color.fromRGBO(253, 106, 116, 0.7);

const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

final String confirmOTPtxt = "Confirm your OTP";
