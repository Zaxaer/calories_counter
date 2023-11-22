import 'package:calories_calculator/resources/app_fonts.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final bgLight = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFFFDF1DE),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFFDF1DE),
        elevation: 0,
        shadowColor: Color(0xFFFDF1DE),
        titleTextStyle: TextStyle(
          color: Color(0xFFD75755),
          fontWeight: FontWeight.w800,
          fontFamily: AppFonts.mPlusRounded,
          fontSize: 18,
          height: 1.596,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFF6C042),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFFD75755),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFFF6C042),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(
            const Size(142, 40),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ));
}
