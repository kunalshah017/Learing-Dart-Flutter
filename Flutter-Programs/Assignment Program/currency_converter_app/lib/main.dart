import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CurrencyConverterPage(),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  double? _convertedValue1;
  double? _convertedValue2;
  double? _convertedValue3;

  // Hardcoded conversion rates from INR
  final double _rateToUSD = 0.012; // 1 INR = 0.012 USD
  final double _rateToEUR = 0.011; // 1 INR = 0.011 EUR
  final double _rateToJPY = 1.45; // 1 INR = 1.45 JPY

  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount != null) {
      setState(() {
        _convertedValue1 = amount * _rateToUSD;
        _convertedValue2 = amount * _rateToEUR;
        _convertedValue3 = amount * _rateToJPY;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter (INR)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount in INR',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            if (_convertedValue1 != null)
              Text('Converted to USD: ${_convertedValue1!.toStringAsFixed(2)}'),
            if (_convertedValue2 != null)
              Text('Converted to EUR: ${_convertedValue2!.toStringAsFixed(2)}'),
            if (_convertedValue3 != null)
              Text('Converted to JPY: ${_convertedValue3!.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
