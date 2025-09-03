import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:takhmin_sura/intro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Intro());
  }
}
