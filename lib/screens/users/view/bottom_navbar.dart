import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_view.dart'; // <-- IMPORT YOUR NEW HOME VIEW
import 'profile_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // UPDATED: Replaced the placeholder with the HomeView widget
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(), // <-- USE THE HOME VIEW HERE
    Center(child: Text('Reorder Page')),
    ProfileView(),
  ];

  // We can remove the permission request from here as the HomeController now handles it
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _requestPermissions();
  //   });
  // }
  //
  // Future<void> _requestPermissions() async {
  //   await Permission.location.request();
  //   await Permission.notification.request();
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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