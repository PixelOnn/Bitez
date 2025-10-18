import 'package:flutter/material.dart';

class FavoriteItemsView extends StatelessWidget {
  const FavoriteItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              "No Favorites Yet",
              style: TextStyle(fontSize: 22, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              "Tap the heart on any dish to save it here.",
              style: TextStyle(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
