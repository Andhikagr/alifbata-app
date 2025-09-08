import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:takhmin_sura/homepage.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with TickerProviderStateMixin {
  Future<void> _goHomepage() async {
    await precacheImage(AssetImage("assets/frone.png"), context);
    if (!mounted) return;
    await precacheImage(AssetImage("assets/frtwo.png"), context);
    if (!mounted) return;
    await precacheImage(AssetImage("assets/frthree.png"), context);
    if (!mounted) return;
    await precacheImage(AssetImage("assets/frfour.png"), context);
    if (!mounted) return;
    await precacheImage(AssetImage("assets/bg-7.jpg"), context);

    Get.offAll(
      () => Homepage(),
      transition: Transition.native,
      duration: Duration(milliseconds: 1000),
    );
  }

  late AnimationController _boxController;
  late Animation<double> _opacityAnimation;

  late AnimationController _earthController;
  //awan 1
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  //awan 2
  late AnimationController _cloudController;
  late Animation<double> _cloudOffset;

  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;

  //animation posirioned
  double earthBottom = -300;
  double cloudOneBottom = -500;
  double cloudTwo = 0;

  @override
  void initState() {
    super.initState();

    // Jalankan animasi setelah build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        earthBottom = -125;
        cloudOneBottom = -150;
        cloudTwo = 80; // posisi akhir
      });
    });

    //animasi earth
    _earthController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _earthController.repeat();

    //bounce
    _bounceController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    //awan 2

    _cloudController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _cloudOffset = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _cloudController, curve: Curves.easeInOut),
    );

    _boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _boxController, curve: Curves.easeIn));

    Future.delayed(Duration(seconds: 2)).then((_) {
      _boxController.forward();
    });

    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    //atur animasi 2
    _logoAnimation = Tween<Offset>(
      begin: Offset(0, -20),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _logoController.forward();
  }

  @override
  void dispose() {
    _earthController.dispose();
    _bounceController.dispose();
    _cloudController.dispose();
    _logoController.dispose();
    _boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2196F3),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg-7.jpg', fit: BoxFit.cover),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _logoAnimation,

              child: Image.asset('assets/alifbata.png'),
            ),
          ),

          Positioned(
            bottom: 400,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _bounceAnimation,
                  child: GestureDetector(
                    onTap: _goHomepage,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 193, 9),
                            blurRadius: 1,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Center(
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            bottom: cloudOneBottom,
            right: 200,
            left: -250,
            child: ScaleTransition(
              scale: _bounceAnimation,
              child: Image.asset('assets/cloud-1.png'),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            bottom: cloudOneBottom,
            left: 250,
            right: -180,
            child: ScaleTransition(
              scale: _bounceAnimation,
              child: Image.asset('assets/cloud-1.png'),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            bottom: earthBottom,
            left: 0,
            right: 0,
            child: RotationTransition(
              turns: _earthController,
              child: Image.asset('assets/earth.png'),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.easeIn,
            bottom: cloudTwo,
            right: 250,
            left: 0,
            child: AnimatedBuilder(
              animation: _cloudOffset,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_cloudOffset.value, 0),
                  child: child,
                );
              },
              child: Image.asset('assets/cloud-1.png', scale: 13),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.easeIn,
            bottom: cloudTwo,
            left: 200,
            right: 0,
            child: AnimatedBuilder(
              animation: _cloudOffset,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_cloudOffset.value, 0),
                  child: child,
                );
              },
              child: Image.asset('assets/cloud-1.png', scale: 1),
            ),
          ),
        ],
      ),
    );
  }
}
