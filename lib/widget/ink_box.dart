import 'package:flutter/material.dart';

class InkBox extends StatelessWidget {
  final VoidCallback onTap;
  final String imageBox;

  const InkBox({super.key, required this.onTap, required this.imageBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          Image.asset(imageBox),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                onTap: onTap,
                child: Ink(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
