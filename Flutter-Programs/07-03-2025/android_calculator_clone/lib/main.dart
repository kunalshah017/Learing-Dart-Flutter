import 'package:android_calculator_clone/pages/calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Android Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          brightness: Brightness.light,
          surface: Colors.brown.shade700,
          surfaceTint: Color.fromARGB(255, 37, 18, 4),
          onSurface: const Color.fromARGB(255, 252, 231, 223),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown,
          elevation: 0,
          iconTheme: IconThemeData(
            color: const Color.fromARGB(255, 233, 227, 225),
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          brightness: Brightness.dark,
        ),
      ),
      home: Calculator(),
    );
  }
}
