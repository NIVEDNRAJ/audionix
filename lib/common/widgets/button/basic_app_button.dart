import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double ? height;
  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 80,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffA5033D), Color(0xffFF6F61)], // Soft, neutral gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(60)), // Adjust corner radius if needed
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black, // Text color can be adjusted
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );

  }
}