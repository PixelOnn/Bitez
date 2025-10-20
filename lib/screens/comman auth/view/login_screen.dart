// lib/screens/common_auth/view/login_screen.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../controller/auth_controller.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();

      // Pass the existing _authController instance
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phoneNumber: phoneNumber,
            authController: _authController, // Pass the instance here
          ),
        ),
      );
      _authController.sendOtp(context, phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... your build method remains the same
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/animations/Verification Code.json',
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enter your phone number",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "99999 99999",
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        child: Text("+91", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length != 10) {
                        return 'Please enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendOtp,
                      child: const Text("Continue"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}