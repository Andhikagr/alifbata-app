import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Mari belajar!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,

                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Stack(
                children: [
                  Image.asset("assets/frone.png"),
                  Positioned.fill(
                    child: InkBox(
                      onTap: () => Get.to(
                        () => Pemula(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Stack(
                children: [
                  Image.asset("assets/frtwo.png"),
                  Positioned.fill(child: InkBox(onTap: () {})),
                ],
              ),
              SizedBox(height: 15),
              Stack(
                children: [
                  Image.asset("assets/frthree.png"),
                  Positioned.fill(child: InkBox(onTap: () {})),
                ],
              ),
              SizedBox(height: 15),
              Stack(
                children: [
                  Image.asset("assets/frfour.png"),
                  Positioned.fill(child: InkBox(onTap: () {})),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
