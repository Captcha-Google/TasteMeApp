import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:taste_me_app/view/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: IntroductionScreen(
        globalBackgroundColor: const Color(0XFFB70404),
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        pages: [
          PageViewModel(
            decoration: const PageDecoration(
              pageColor: Color(0xFFB70404),
            ),
            titleWidget: const Text(
              "Discover Local Restaurants",
              style: TextStyle(
                fontSize: 43,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodyWidget: const Text(
              "Explore new dining experiences and support local businesses along the way.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            image: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50),
              child: SvgPicture.asset("assets/image_3.svg"),
            ),
          ),
          PageViewModel(
            decoration: const PageDecoration(pageColor: Color(0xFFB70404)),
            titleWidget: const Text(
              "Easy-to-Use Interface",
              style: TextStyle(
                fontSize: 45,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodyWidget: const Text(
              "Enjoy a seamless and enjoyable ordering experience from start to finish.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            image: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 45),
              child: SvgPicture.asset(
                "assets/image_1.svg",
                width: 300,
              ),
            ),
          ),
          PageViewModel(
            decoration: const PageDecoration(
              pageColor: Color(0xFFB70404),
            ),
            useScrollView: true,
            titleWidget: const Text(
              "Easy Online Ordering",
              style: TextStyle(
                fontSize: 45,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodyWidget: const Text(
              "Say goodbye to lengthy phone calls and waiting times.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            image: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              child: SvgPicture.asset(
                "assets/image_4.svg",
                width: 300,
              ),
            ),
          ),
        ],
        showSkipButton: true,
        skip: const Text(
          "Skip",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        next: const Text(
          "Next",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        done: const Text(
          "Done",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onDone: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isFirstTimeInstall', true);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        onSkip: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.white,
          color: Colors.white12,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
