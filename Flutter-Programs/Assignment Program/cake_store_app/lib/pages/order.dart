import 'package:flutter/material.dart';
import 'product.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? _selectedCake;
  final TextEditingController _quantityController = TextEditingController();
  double _totalBill = 0.0;
  bool _hasCalculated = false;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    setState(() {
      if (_selectedCake != null && _quantityController.text.isNotEmpty) {
        int quantity = int.tryParse(_quantityController.text) ?? 0;

        // Find the price of the selected cake
        final selectedCakePrice =
            ProductPage.cakes
                .firstWhere((cake) => cake.name == _selectedCake)
                .price;

        _totalBill = selectedCakePrice * quantity;
        _hasCalculated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Your Order'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cake selection dropdown
            const Text(
              'Select Cake:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
                  hint: const Text('Choose a cake'),
                  value: _selectedCake,
                  items:
                      ProductPage.cakes.map((cake) {
                        return DropdownMenuItem<String>(
                          value: cake.name,
                          child: Text(
                            '${cake.name} (\₹${cake.price.toStringAsFixed(2)})',
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCake = value;
                      _hasCalculated = false;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Quantity input
            const Text(
              'Enter Quantity:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                hintText: 'How many cakes?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() => _hasCalculated = false),
            ),

            const SizedBox(height: 30),

            // Calculate button
            Center(
              child: ElevatedButton(
                onPressed: _calculateTotal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: const Text('Calculate Total'),
              ),
            ),

            const SizedBox(height: 30),

            // Display total bill
            if (_hasCalculated) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  border: Border.all(color: Colors.pink.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildSummaryRow('Cake:', _selectedCake ?? ''),
                    _buildSummaryRow('Quantity:', _quantityController.text),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Bill:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\₹${_totalBill.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
