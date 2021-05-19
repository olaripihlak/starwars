// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const cardBgColorLight = Color(0xFF00CE00);
const cardBgColorDark = Color(0xFF007900);

const primaryColorDark = Color(0xFF003F00);

ThemeData darkTheme = ThemeData(
    accentColor: Colors.blueGrey,
    brightness: Brightness.dark,
    primaryColor: primaryColorDark);

ThemeData getDarkTheme(BuildContext context) {
  return ThemeData(
      accentColor: Colors.blueGrey,
      brightness: Brightness.dark,
      primaryColor: primaryColorDark,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Colors.green));
}

ThemeData getLightTheme(BuildContext context) {
  return ThemeData(
      accentColor: Colors.pink,
      brightness: Brightness.light,
      primaryColor: Colors.greenAccent,
      textTheme: GoogleFonts.pattayaTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Colors.amberAccent));
}
