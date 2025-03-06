import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController firstNumberController = TextEditingController();
  final TextEditingController secondNumberController = TextEditingController();
  double result = 0;

  void calculateResult() {
    double firstNumber = double.parse(firstNumberController.text);
    double secondNumber = double.parse(secondNumberController.text);
    setState(() {
      result = firstNumber + secondNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Adder')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter a number"),
            ),
            Text("+", style: TextStyle(fontSize: 30)),
            TextField(
              controller: secondNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter another number"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateResult();
              },
              child: const Text("=", style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 20),
            Text(
              "Result: $result",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
