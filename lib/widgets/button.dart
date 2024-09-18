import 'package:flutter/material.dart';

class ButtonHalley extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color hoverColor;
  final double borderRadius;

  const ButtonHalley({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white, 
    this.hoverColor = Colors.blueAccent, 
    this.borderRadius = 3.0, 
  });

  @override
  _ButtonHalleyState createState() => _ButtonHalleyState();
}

class _ButtonHalleyState extends State<ButtonHalley> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: widget.textColor, backgroundColor: _isHovered ? widget.hoverColor : widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
