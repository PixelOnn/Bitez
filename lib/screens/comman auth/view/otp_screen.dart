import 'dart:async'; // <-- ADD THIS
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../controller/auth_controller.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final AuthController authController;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.authController,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Generate 6 controllers and focus nodes for a 6-digit OTP
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (index) => FocusNode());

  // --- NEW STATE VARIABLES ---
  bool _isLoading = false;
  bool _isTimerRunning = true;
  int _timerSeconds = 30;
  Timer? _timer;
  // -------------------------

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the countdown on screen load

    for (int i = 0; i < 6; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1 && i < 5) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      });
    }
  }

  // --- NEW METHODS ---
  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
      _timerSeconds = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isTimerRunning = false;
        });
      }
    });
  }

  void _resendOtp() {
    // Show a quick feedback message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resending OTP...")),
    );
    // Call the original sendOtp function again
    widget.authController.sendOtp(context, widget.phoneNumber);
    // Restart the timer
    _startTimer();
  }
  // --------------------

  // --- UPDATED METHOD ---
  Future<void> _verifyOtp() async {
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      setState(() {
        _isLoading = true; // Start loading
      });
      try {
        await widget.authController.verifyOtp(context, otp, widget.phoneNumber);
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete 6-digit OTP.")),
      );
    }
  }
  // --------------------

  @override
  void dispose() {
    _timer?.cancel(); // Important: cancel timer to prevent memory leaks
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/animations/Verification Code.json',
                    height: 250,
                  ),
                ),
                const Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "We have sent the verification code to your phone number +91 ${widget.phoneNumber}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 48,
                      height: 52,
                      child: TextFormField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // --- NEW WIDGET FOR TIMER/RESEND ---
                Align(
                  alignment: Alignment.center,
                  child: _isTimerRunning
                      ? Text(
                    "Resend OTP in $_timerSeconds s",
                    style: TextStyle(color: Colors.black),
                  )
                      : TextButton(
                    onPressed: _resendOtp,
                    child: const Text("Resend OTP"),
                  ),
                ),
                // -------------------------------------
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55, // Give button a fixed height
                  child: ElevatedButton(
                    // --- UPDATED WIDGET FOR LOADING ---
                    onPressed: _isLoading ? null : _verifyOtp,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text("Confirm"),
                    // ------------------------------------
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}