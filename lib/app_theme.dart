import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.lightGreenAccent[100],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.grey[50],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.lightGreenAccent[100],
      foregroundColor: Colors.grey[400],
    ),
  );
}
