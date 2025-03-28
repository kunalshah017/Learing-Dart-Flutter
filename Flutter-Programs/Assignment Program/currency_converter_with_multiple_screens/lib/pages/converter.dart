import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  double _result = 0;
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';

  // Simple currency exchange rates (fixed for demo)
  final Map<String, Map<String, double>> _exchangeRates = {
    'USD': {'EUR': 0.92, 'GBP': 0.79, 'JPY': 151.25, 'INR': 83.50, 'USD': 1.0},
    'EUR': {'USD': 1.09, 'GBP': 0.85, 'JPY': 164.48, 'INR': 90.76, 'EUR': 1.0},
    'GBP': {'USD': 1.27, 'EUR': 1.17, 'JPY': 192.51, 'INR': 106.16, 'GBP': 1.0},
    'JPY': {
      'USD': 0.0066,
      'EUR': 0.0061,
      'GBP': 0.0052,
      'INR': 0.55,
      'JPY': 1.0,
    },
    'INR': {'USD': 0.012, 'EUR': 0.011, 'GBP': 0.0094, 'JPY': 1.81, 'INR': 1.0},
  };

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'INR'];

  void _convertCurrency() {
    setState(() {
      if (_amountController.text.isEmpty) {
        _result = 0;
        return;
      }

      double amount = double.tryParse(_amountController.text) ?? 0;
      double rate = _exchangeRates[_fromCurrency]![_toCurrency]!;
      _result = amount * rate;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.monetization_on),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (_) => _convertCurrency(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('From:'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _fromCurrency,
                            items:
                                _currencies.map((currency) {
                                  return DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _fromCurrency = value!;
                                _convertCurrency();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    setState(() {
                      final temp = _fromCurrency;
                      _fromCurrency = _toCurrency;
                      _toCurrency = temp;
                      _convertCurrency();
                    });
                  },
                  icon: const Icon(Icons.swap_horiz),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To:'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _toCurrency,
                            items:
                                _currencies.map((currency) {
                                  return DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _toCurrency = value!;
                                _convertCurrency();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Result:', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text(
                      '${_amountController.text.isEmpty ? "0" : _amountController.text} $_fromCurrency = ${_result.toStringAsFixed(2)} $_toCurrency',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
