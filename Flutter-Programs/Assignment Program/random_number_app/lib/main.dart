import 'package:flutter/material.dart';
import 'dart:math'; // Import for random number generation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Number Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RandomNumberPage(title: 'Random Number Generator'),
    );
  }
}

class RandomNumberPage extends StatefulWidget {
  const RandomNumberPage({super.key, required this.title});

  final String title;

  @override
  State<RandomNumberPage> createState() => _RandomNumberPageState();
}

class _RandomNumberPageState extends State<RandomNumberPage> {
  // Initialize with 0 (no random number generated yet)
  int _randomNumber = 0;
  // Create a Random object for generating random numbers
  final Random _random = Random();

  // Function to generate a random number between 1 and 100
  void _generateRandomNumber() {
    setState(() {
      _randomNumber = _random.nextInt(100) + 1; // Random number between 1-100
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your random number is:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _randomNumber == 0 ? 'Press the button below' : '$_randomNumber',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomNumber,
        tooltip: 'Generate Random Number',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.casino, color: Colors.white),
      ),
    );
  }
}
