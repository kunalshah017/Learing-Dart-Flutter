import 'package:flutter/material.dart';
import 'package:product_purchase_navigation/pages/payment.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/product.jpeg', width: 300),
            Text(
              'Lenovo LOQ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text('1000 \$', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentScreen(),
                  ),
                );
              },
              child: Text('Buy Now', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
