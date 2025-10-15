import 'dart:io'; // <-- ADD THIS IMPORT
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // <-- ADD THIS IMPORT
import 'package:device_info_plus/device_info_plus.dart'; // <-- ADD THIS IMPORT

import '../../users/model/user_model.dart' as AppUser;
import '../../users/view/home_screen.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // <-- ADD THIS
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin(); // <-- ADD THIS

  String? _verificationId;

  // ... sendOtp method remains the same ...
  Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification Failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
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
        await _saveUserData(userCredential.user!, phoneNumber); // This function will now save more data
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

  // Helper method to get the FCM token
  Future<String?> _getFcmToken() async {
    // You might want to request notification permissions here in a real app
    return await _firebaseMessaging.getToken();
  }

  // Helper method to get device information
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        return androidInfo.data; // .data gives a map of all device info
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        return iosInfo.data; // .data gives a map of all device info
      }
    } catch (e) {
      print("Failed to get device info: $e");
    }
    return {};
  }

  // UPDATED: Save new user data including FCM token and device info
  Future<void> _saveUserData(User user, String phoneNumber) async {
    final userRef = _firestore.collection('Users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      // Fetch the token and device info
      final String? fcmToken = await _getFcmToken();
      final Map<String, dynamic> deviceInfo = await _getDeviceInfo();

      final newUser = AppUser.UserModel(
        uid: user.uid,
        phoneNumber: phoneNumber,
        createdAt: Timestamp.now(),
        fcmToken: fcmToken,       // Pass the token
        deviceInfo: deviceInfo,   // Pass the device info
      );
      await userRef.set(newUser.toMap());
    }
  }
}