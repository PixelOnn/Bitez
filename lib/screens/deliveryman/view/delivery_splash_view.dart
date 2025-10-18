import 'package:bitez/screens/deliveryman/view/delivery_login_view.dart';
import 'package:flutter/material.dart';

class DeliverySplashView extends StatefulWidget {
  const DeliverySplashView({super.key});

  @override
  State<DeliverySplashView> createState() => _DeliverySplashViewState();
}

class _DeliverySplashViewState extends State<DeliverySplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showLanguageSelector());
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        String selectedLanguage = 'English'; // Default selection
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a language to continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<String>(
                    title: const Text('English'),
                    value: 'English',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setModalState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('தமிழ்'),
                    value: 'Tamil',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setModalState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('हिन्दी'),
                    value: 'Hindi',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setModalState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // In a real app, you would save this language preference
                        Navigator.pop(context); // Close the bottom sheet
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeliveryLoginView()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Confirm'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Lottie Animation Placeholder',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
