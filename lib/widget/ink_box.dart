import 'package:flutter/material.dart';

class InkBox extends StatelessWidget {
  final VoidCallback onTap;

  const InkBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashColor: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Ink(decoration: BoxDecoration(color: Colors.transparent)),
      ),
    );
  }
}
