import 'package:flutter/material.dart';

class ColorTap extends StatefulWidget {
  const ColorTap({super.key});

  @override
  State<ColorTap> createState() => _ColorTapState();
}

class _ColorTapState extends State<ColorTap> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.black,
    Colors.white,
  ];

  int currentIndex = 0;

  void changeColor() {
    setState(() {
      currentIndex++;
      if (currentIndex == colors.length) {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: changeColor,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          color: colors[currentIndex],
          alignment: Alignment.center,
          child: const Text(
            'Tap Here',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
