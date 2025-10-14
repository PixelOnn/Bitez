// lib/screens/common_auth/view/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  final List<Map<String, String>> _splashData = [
    {'animation': 'assets/animations/anim1.json', 'text': 'Welcome to Kangeyam Foods!'},
    {'animation': 'assets/animations/anim2.json', 'text': 'Order Your Favorite Meals'},
    {'animation': 'assets/animations/anim3.json', 'text': 'Fastest Delivery to Your Doorstep'},
  ];

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() {
    Timer(const Duration(seconds: 3), () {
      if (_currentIndex < _splashData.length - 1) {
        setState(() {
          _currentIndex++;
        });
        _startAnimationSequence();
      } else {
        // After the last animation, navigate to the login screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              _splashData[_currentIndex]['animation']!,
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Text(
              _splashData[_currentIndex]['text']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}