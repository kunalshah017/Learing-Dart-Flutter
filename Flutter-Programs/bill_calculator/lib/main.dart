import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calculate your bill 🤑'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  double totalPrice = 0.0;

  void calculateTotal() {
    final double price = double.tryParse(priceController.text) ?? 0.0;
    final int quantity = int.tryParse(quantityController.text) ?? 0;

    setState(() {
      totalPrice = price * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/money_money.gif", height: 300, width: 300),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Price: ',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Unit Price',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Quantity: ',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Quantity',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateTotal,
                child: Text(
                  'Calculate',
                  style: GoogleFonts.comicNeue(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your Total: \$${totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.comicNeue(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
