import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/deliveryman_model.dart';
import '../view/delivery_setup_settings_view.dart';


class DeliveryAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _verificationId;

  Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
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
        const SnackBar(content: Text("Verification ID not found.")),
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
        await _saveDeliverymanData(userCredential.user!, phoneNumber);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DeliverySettingsView()),
              (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP or error: ${e.toString()}")),
      );
    }
  }

  Future<void> _saveDeliverymanData(User user, String phoneNumber) async {
    final docRef = _firestore.collection('deliverymen').doc(user.uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      final newDeliveryman = DeliverymanModel(
        uid: user.uid,
        phoneNumber: phoneNumber,
        createdAt: Timestamp.now(),
      );
      await docRef.set(newDeliveryman.toMap());
    }
  }
}
