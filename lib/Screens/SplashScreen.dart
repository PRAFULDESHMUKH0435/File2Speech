import 'dart:async';
import 'package:flutter/material.dart';
import 'package:texttospeech/Screens/HomeScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       decoration: const BoxDecoration(
         image: DecorationImage(image: AssetImage("Assets/Images/splash_image.jpg"),fit: BoxFit.fill)
       ),
      ),
    );
  }
}
