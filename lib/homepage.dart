import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:takhmin_sura/level_one/pemula.dart';
import 'package:takhmin_sura/widget/ink_box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg-7.jpg', fit: BoxFit.cover),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkBox(
                    imageBox: "assets/frone.png",
                    onTap: () => Get.to(
                      () => Pemula(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 400),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkBox(onTap: () {}, imageBox: "assets/frtwo.png"),
                  SizedBox(height: 30),
                  InkBox(onTap: () {}, imageBox: "assets/frthree.png"),
                  SizedBox(height: 30),
                  InkBox(onTap: () {}, imageBox: "assets/frfour.png"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
