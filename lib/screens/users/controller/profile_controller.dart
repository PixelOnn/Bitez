import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../comman auth/view/login_screen.dart';

class ProfileController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // After signing out, navigate back to the login screen and clear all previous routes
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error signing out: ${e.toString()}")),
      );
    }
  }
}