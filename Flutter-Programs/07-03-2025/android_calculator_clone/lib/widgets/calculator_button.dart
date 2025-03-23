import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final IconData? icon;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 30,
    this.icon,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          // Use shape or borderRadius, not both
          shape: _isPressed ? BoxShape.rectangle : BoxShape.circle,
          // Only use borderRadius when shape is rectangle
          borderRadius: _isPressed ? BorderRadius.circular(25) : null,
        ),
        child: Center(
          child:
              widget.icon != null
                  ? Icon(
                    widget.icon,
                    color: widget.textColor,
                    size: widget.fontSize,
                  )
                  : Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: widget.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
        ),
      ),
    );
  }
}
