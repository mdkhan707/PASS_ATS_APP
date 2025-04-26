import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  // Constructor to accept child widgets
  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000452), // Dark Blue (Top-left and Bottom-right)
              Color(0xFF2A4596), // Lighter Blue (in between)
              Color(0xFF000452), // Dark Blue again (Bottom-right)
            ],
            stops: [
              0.0, // Dark Blue at the top-left
              0.5, // Light Blue in the middle
              1.0, // Dark Blue at the bottom-right
            ],
            begin: Alignment.topLeft, // Gradient starts at the top-left corner
            end: Alignment
                .bottomRight, // Gradient ends at the bottom-right corner
          ),
        ),
        child: child);
  }
}
