import 'package:calories_calculator/ui/my_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final app = MyApp();
  runApp(app);
}
