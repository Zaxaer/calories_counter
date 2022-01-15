import 'package:calorie_calculator_exemple/resources/app_fonts.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final bgLight = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFFDF1DE),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFFDF1DE),
      elevation: 0,
      shadowColor: Color(0xFFFDF1DE),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF6C042),
      unselectedItemColor: Colors.white,
      selectedItemColor: Color(0xFFD75755),
    ),
  );
}
