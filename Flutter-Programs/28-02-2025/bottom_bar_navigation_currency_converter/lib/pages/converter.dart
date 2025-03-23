import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController _controller = TextEditingController();

  double fromValue = 0;
  double toValue = 0;

  void onFromCurrencyChanged(String value) {
    setState(() {
      fromController.text = value;
    });
  }

  void onToCurrencyChanged(String value) {
    setState(() {
      toController.text = value;
    });
  }

  void onConvert() {
    setState(() {
      if (_controller.text.isEmpty) {
        return;
      }

      fromValue = double.tryParse(_controller.text) ?? 0;

      String fromCurrency = fromController.text;
      String toCurrency = toController.text;

      if (fromCurrency.isEmpty) fromCurrency = "USD";
      if (toCurrency.isEmpty) toCurrency = "USD";

      Map<String, double> rates = {
        "USD": 1.0,
        "INR": 83.5,
        "EUR": 0.92,
        "GBP": 0.77,
      };

      double amountInUsd = fromValue / rates[fromCurrency]!;

      toValue = amountInUsd * rates[toCurrency]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Currency Converter")),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu(
                      controller: fromController,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                          label: "USD",
                          value: "USD",
                          leadingIcon: const Text(
                            "🇺🇸",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        DropdownMenuEntry(
                          label: "INR",
                          value: "INR",
                          leadingIcon: const Text(
                            "🇮🇳",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        DropdownMenuEntry(
                          label: "EUR",
                          value: "EUR",
                          leadingIcon: const Text(
                            "🇪🇺",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        DropdownMenuEntry(
                          label: "GBP",
                          value: "GBP",
                          leadingIcon: const Text(
                            "🇬🇧",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),

                    DropdownMenu(
                      controller: toController,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                          label: "USD",
                          value: "USD",
                          leadingIcon: const Text(
                            "🇺🇸",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        DropdownMenuEntry(
                          label: "INR",
                          value: "INR",
                          leadingIcon: const Text(
                            "🇮🇳",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        DropdownMenuEntry(
                          label: "EUR",
                          value: "EUR",
                          leadingIcon: const Text(
                            "🇪🇺",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        DropdownMenuEntry(
                          label: "GBP",
                          value: "GBP",
                          leadingIcon: const Text(
                            "🇬🇧",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("From", style: const TextStyle(fontSize: 20)),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Amount",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onConvert,
                  child: const Text("Convert"),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Result: $toValue",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
