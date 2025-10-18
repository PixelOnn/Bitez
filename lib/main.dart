import 'package:bitez/screens/comman%20auth/view/splash_screen.dart';
import 'package:bitez/screens/users/controller/cart_controller.dart';
import 'package:bitez/screens/users/users%20app%20theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import Provider


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider( // Wrap the app with ChangeNotifierProvider for CartController
      create: (context) => CartController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bitez',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
