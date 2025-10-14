// lib/main.dart
import 'package:bitez/screens/comman%20auth/view/otp_screen.dart';
import 'package:bitez/screens/comman%20auth/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // Start with the splash screen
      home: const SplashScreen(),
      routes: {
        // Define route for OTP screen to be navigated to from controller
        '/otp': (context) => OtpScreen(phoneNumber: ''),
      },
    );
  }
}