import 'package:flutter/material.dart';

class Pemula extends StatefulWidget {
  const Pemula({super.key});

  @override
  State<Pemula> createState() => _PemulaState();
}

class _PemulaState extends State<Pemula> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
            children: [
              Image.asset("assets/mobil.png"),
              Text(
                "سيارة",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
