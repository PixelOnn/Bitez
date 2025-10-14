// lib/screens/common_auth/controller/auth_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../users/model/user_model.dart' as AppUser;
import '../../users/view/home_screen.dart';
import 'package:flutter/material.dart';


class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _verificationId;

  // Function to send OTP to the user's phone number
  Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber, // Add your country code
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification Failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          // Navigate to OTP screen
          Navigator.pushNamed(context, '/otp');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  // Function to verify the OTP entered by the user
  Future<void> verifyOtp(BuildContext context, String otp, String phoneNumber) async {
    if (_verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification ID not found. Please try again.")),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Save user data to Firestore
        await _saveUserData(userCredential.user!, phoneNumber);

        // Navigate to Home Screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP or error: ${e.toString()}")),
      );
    }
  }

  // Save new user data to the "Users" collection
  Future<void> _saveUserData(User user, String phoneNumber) async {
    final userRef = _firestore.collection('Users').doc(user.uid);

    // Check if user already exists
    final doc = await userRef.get();
    if (!doc.exists) {
      final newUser = AppUser.UserModel(
        uid: user.uid,
        phoneNumber: phoneNumber,
        createdAt: Timestamp.now(),
      );
      await userRef.set(newUser.toMap());
    }
  }
}