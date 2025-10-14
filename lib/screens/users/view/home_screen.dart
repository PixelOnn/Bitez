// lib/screens/users/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Placeholder pages for the bottom navigation bar
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Home Page')),
    Center(child: Text('Reorder Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the dialog is shown after the build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissions();
    });
  }

  Future<void> _requestPermissions() async {
    // Request Location Permission
    PermissionStatus locationStatus = await Permission.location.request();
    if (locationStatus.isDenied) {
      // Handle denied case
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Location permission is required to find nearby restaurants."),
      ));
    }

    // Request Notification Permission
    PermissionStatus notificationStatus = await Permission.notification.request();
    if (notificationStatus.isDenied) {
      // Handle denied case
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Delivery"),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.replay),
            label: 'Reorder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}