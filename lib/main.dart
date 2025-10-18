import 'package:bitez/screens/comman%20auth/view/splash_screen.dart';
import 'package:bitez/screens/users/controller/cart_controller.dart';
import 'package:bitez/screens/users/users%20app%20theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- ADD THESE IMPORTS FOR FIREBASE ---
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure you have this file from your FlutterFire setup
// -------------------------------------


void main() async {
  // --- RETAINED AND ENABLED INIT LOGIC ---
  // This is required to fix the error in your screenshot
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ------------------------------------------

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap with ChangeNotifierProvider for CartController
    return ChangeNotifierProvider(
      create: (context) => CartController(),
      child: MaterialApp(
        title: 'Bitez',
        debugShowCheckedModeBanner: false,

        // Apply the theme
        theme: AppTheme.lightTheme,

        // Start the app at the splash screen
        home: const SplashScreen(),
      ),
    );
  }
}