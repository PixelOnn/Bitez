import 'package:bitez/screens/deliveryman/controller/delivery_auth_controller.dart';
import 'package:bitez/screens/deliveryman/view/delivery_otp_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeliveryLoginView extends StatefulWidget {
  const DeliveryLoginView({super.key});

  @override
  State<DeliveryLoginView> createState() => _DeliveryLoginViewState();
}

class _DeliveryLoginViewState extends State<DeliveryLoginView> {
  final TextEditingController _phoneController = TextEditingController();
  final DeliveryAuthController _authController = DeliveryAuthController();
  final _formKey = GlobalKey<FormState>();

  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeliveryOtpView(
            phoneNumber: phoneNumber,
            authController: _authController,
          ),
        ),
      );
      _authController.sendOtp(context, phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    "Delivery Partner Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enter your phone number to continue",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
                      child: const Text("Send OTP"),
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

