import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _opacityLevel = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              'https://m.media-amazon.com/images/I/81f7dTXcl4L._SX679_.jpg',
            ),
            SizedBox(height: 8),
            Text('Lenovo LOQ'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed:
                  () => {
                    setState(() {
                      if (_opacityLevel == 1.0) {
                        _opacityLevel = 0;
                      } else {
                        _opacityLevel = 1.0;
                      }
                    }),
                  },
              child: Text('Show Details'),
            ),
            SizedBox(height: 8),
            AnimatedOpacity(
              opacity: _opacityLevel,
              duration: Duration(milliseconds: 500),
              child: Text(
                'Processor: Intel Core i7-13620H | Speed: 2.4GHz (Base) - 4.9GHz (Max) | 10 Cores | 16 Threads | 24MB Cache Display: 15.6" FHD (1920x1080) IPS Technology | 144 Hz Refresh Rate |Brightness: 350Nits Anti-glare | NVDIA G-Sync || Connectivity : Wifi 6E 11ax (2x2) | Bluetooth 5.1 Memory: 16GB RAM DDR5-5200 | Storage: 512GB SSD (Expandable upto 1TB)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
