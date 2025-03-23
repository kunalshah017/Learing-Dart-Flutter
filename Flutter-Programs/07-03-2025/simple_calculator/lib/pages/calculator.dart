import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();

  String _selectedOperator = '+';
  String _result = '';

  final List<String> _operators = ['+', '-', '*', '/'];

  void _calculateResult() {
    try {
      final double firstNumber = double.parse(_firstNumberController.text);
      final double secondNumber = double.parse(_secondNumberController.text);

      double calculatedResult = 0;

      switch (_selectedOperator) {
        case '+':
          calculatedResult = firstNumber + secondNumber;
          break;
        case '-':
          calculatedResult = firstNumber - secondNumber;
          break;
        case '*':
          calculatedResult = firstNumber * secondNumber;
          break;
        case '/':
          if (secondNumber == 0) {
            setState(() {
              _result = 'Cannot divide by zero';
            });
            return;
          }
          calculatedResult = firstNumber / secondNumber;
          break;
      }

      setState(() {
        _result = calculatedResult.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Invalid Inputs';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Number',
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton(
                        value: _selectedOperator,
                        underline: Container(),
                        items:
                            _operators.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedOperator = newValue;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _secondNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Second Number',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _calculateResult,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('=', style: TextStyle(fontSize: 24)),
                ),
                SizedBox(height: 24),
                Column(
                  children: [
                    Text('Result:', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
