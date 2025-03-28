import 'package:flutter/material.dart';

class Cake {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const Cake({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  static const List<Cake> cakes = [
    Cake(
      name: 'Chocolate Truffle Cake',
      description:
          'Rich and moist chocolate cake layers filled with chocolate truffle cream. Perfect for chocolate lovers!',
      price: 499,
      imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587',
    ),
    Cake(
      name: 'Strawberry Cheesecake',
      description:
          'Creamy cheesecake topped with fresh strawberry glaze on a graham cracker crust.',
      price: 399,
      imageUrl: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187',
    ),
    Cake(
      name: 'Vanilla Bean Cake',
      description:
          'Light and fluffy vanilla cake with real vanilla bean specks and smooth vanilla buttercream frosting.',
      price: 359,
      imageUrl: 'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Cakes'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cakes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                  child: Image.network(
                    '${cakes[index].imageUrl}?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey.shade300,
                        child: const Center(child: Text('Image not available')),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cakes[index].name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\₹${cakes[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cakes[index].description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
