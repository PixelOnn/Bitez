import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'profile_view.dart'; // <-- IMPORT YOUR NEW PROFILE VIEW

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // UPDATED: Replaced the placeholder with the ProfileView widget
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Home Page')),
    Center(child: Text('Reorder Page')),
    ProfileView(), // <-- USE THE PROFILE VIEW HERE
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissions();
    });
  }

  Future<void> _requestPermissions() async {
    // ... your permission logic remains the same
    await Permission.location.request();
    await Permission.notification.request();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar is now inside the specific views (like ProfileView)
      // to allow each tab to have its own title. You can remove this one.
      // appBar: AppBar(
      //   title: const Text("Food Delivery"),
      // ),
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