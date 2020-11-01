import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.blueGrey[800],
    primaryColorLight: Colors.blueGrey[50],
    primaryColorDark: Colors.blueGrey[900],
    accentColor: Colors.lightGreenAccent[100],
    cardColor: Colors.blueGrey[700],
    fontFamily: 'Hind',
    textTheme: TextTheme(
      headline2: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[50],
      ),
      headline3: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[50],
      ),
      headline4: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.lightGreenAccent[100],
      ),
      headline5: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.lightGreenAccent[100],
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[50],
      ),
      subtitle2: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: Colors.blueGrey[200],
      ),
      bodyText1: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey[50],
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.lightGreenAccent[100],
      foregroundColor: Colors.grey[400],
    ),
  );
}
