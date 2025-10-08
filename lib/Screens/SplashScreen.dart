import 'dart:async';
import 'package:covid_data/Screens/Homescreen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: controller.value * 2.0 * math.pi,
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('Assets/virus.jpg'), // Replace 'assets/my_image.png' with your image path
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    ),

                  ),
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.08,
            ),
            Text(
              'Covid-19 \n Tracker App',

              textAlign: TextAlign.center,
              style: TextStyle(

                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
