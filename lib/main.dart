import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

class PreferencesService {
  static Future<void> init() async {
    await SharedPreferences.getInstance();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5350),
          secondary: const Color(0xFF3B4CCA),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}