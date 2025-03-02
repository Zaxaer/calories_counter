import 'package:calories_calculator/ui/navigation/main_navigation.dart';
import 'package:calories_calculator/ui/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final mainNavigation = MainNavigation();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.bgLight,
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', 'RU')],
    );
  }
}
