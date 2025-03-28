import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const BmiCalculatorApp());
}

class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmiResult = 0;
  String _resultText = '';
  Color _resultColor = Colors.black;

  void _calculateBMI() {
    // Get height in cm and weight in kg
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      setState(() {
        _resultText = "Please enter valid height and weight";
        _resultColor = Colors.red;
        _bmiResult = 0;
      });
      return;
    }

    // Convert height from cm to meters
    height = height / 100;

    // Calculate BMI
    double bmi = weight / pow(height, 2);

    setState(() {
      _bmiResult = bmi;

      if (bmi < 18.5) {
        _resultText = "Underweight";
        _resultColor = Colors.blue;
      } else if (bmi >= 18.5 && bmi < 25) {
        _resultText = "Normal weight";
        _resultColor = Colors.green;
      } else if (bmi >= 25 && bmi < 30) {
        _resultText = "Overweight";
        _resultColor = Colors.orange;
      } else {
        _resultText = "Obesity";
        _resultColor = Colors.red;
      }
    });
  }

  void _reset() {
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bmiResult = 0;
      _resultText = '';
      _resultColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                hintText: 'Enter your height in centimeters',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                hintText: 'Enter your weight in kilograms',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text('Calculate'),
                ),
                ElevatedButton(onPressed: _reset, child: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 24),
            if (_bmiResult > 0)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Your BMI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _bmiResult.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _resultText,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: _resultColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
