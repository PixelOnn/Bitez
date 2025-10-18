// lib/screens/common_auth/view/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart'; // Ensure this path is correct for your project

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to automatically navigate after 5 seconds
    _timer = Timer(const Duration(seconds: 5), _navigateToLogin);
  }

  // Navigate to the LoginScreen and cancel the timer
  void _navigateToLogin() {
    _timer?.cancel(); // Cancel the timer if it's still active
    if (mounted) { // Check if the widget is still in the tree
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Ensure the timer is cancelled when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content: Lottie animation and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/Food Carousel.json', // Your single Lottie animation file
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Judah delivery!', // Your welcome text
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Skip Button overlayed on the bottom right
          Align(
            alignment: Alignment.bottomRight,

          ),
        ],
      ),
    );
  }
}