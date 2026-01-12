import 'package:flutter/material.dart';

class Constants {
  final primaryColor = Colors.blueAccent;
  final secondaryColor = Colors.lightGreen;
  final tertiaryColor = Colors.orange;
  final blackColor = Colors.black;

  final greyColor = Colors.grey;

  final linearGradientBlue = const LinearGradient(
    colors: [Color(0xff000428), Color(0xff004e92)],

    begin: Alignment.topRight,
    end: Alignment.topLeft,
  );

  final linearGradientPurple = const LinearGradient(
    colors: [Color(0xff41295a), Color(0xff2F0743)],

    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}
