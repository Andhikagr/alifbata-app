import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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

    Get.offAll(
      () => _goHomepage(),
      transition: Transition.native,
      duration: Duration(milliseconds: 1000),
    );
  }

  //animasi logo
  late AnimationController _logoController;
  late Animation<double> _opacityAnimation;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  //bumi
  late AnimationController _earthController;
  //awan 1
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  //awan 2
  late AnimationController _cloudController;
  late Animation<double> _cloudOffset;

  //tombol
  late AnimationController _bottonController;
  late Animation<Offset> _bottonAnimation;

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
        earthBottom = -180;
        cloudOneBottom = -150;
        cloudTwo = 100; // posisi akhir
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

    //animasi logo
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    //flip logo
    _flipController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _flipAnimation = Tween<double>(
      begin: 0,
      end: 3.14159,
    ).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeIn));

    Future.delayed(Duration(milliseconds: 5000)).then((_) {
      _flipController.stop(canceled: false);
    });
    //jalankan
    Future.delayed(Duration(milliseconds: 2000)).then((_) {
      _logoController.forward();
    });

    _bottonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    //atur animasi 2
    _bottonAnimation = Tween<Offset>(begin: Offset(-10, 10), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _bottonController, curve: Curves.easeOut),
        );
    Future.delayed(Duration(seconds: 4)).then((_) {
      _bottonController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _earthController.dispose();
    _bounceController.dispose();
    _cloudController.dispose();
    _logoController.dispose();
    _flipController.dispose();
    _bottonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _opacityAnimation,
                child: AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.rotationY(_flipAnimation.value),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                  child: Image.asset('assets/alifbata.png'),
                ),
              ),
              SlideTransition(
                position: _bottonAnimation,
                child: ScaleTransition(
                  scale: _bounceAnimation,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      height: 50,
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
            ],
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            bottom: cloudOneBottom,
            right: 80,
            left: -50,
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
