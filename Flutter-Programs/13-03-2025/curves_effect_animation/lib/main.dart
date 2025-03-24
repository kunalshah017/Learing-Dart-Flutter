import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _width = 200;
  double _height = 200;
  Color _color = Colors.red;
  Curve _curve = Curves.easeOutCubic;

  void _update() {
    setState(() {
      if (_color == Colors.red) {
        _width = 300;
        _height = 300;
        _color = Colors.green;
        _curve:
        Curves.easeInOutCubic;
      } else {
        _width = 200;
        _height = 200;
        _color = Colors.red;
        _curve:
        Curves.easeOutCubic;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          color: _color,
          duration: Duration(milliseconds: 300),
          curve: _curve,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _update,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
