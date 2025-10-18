import 'package:flutter/material.dart';

class DeliveryHomeView extends StatefulWidget {
  const DeliveryHomeView({super.key});

  @override
  State<DeliveryHomeView> createState() => _DeliveryHomeViewState();
}

class _DeliveryHomeViewState extends State<DeliveryHomeView> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Dashboard"),
        actions: [
          Row(
            children: [
              Text(_isOnline ? "Online" : "Offline", style: TextStyle(color: _isOnline ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
              Switch(
                value: _isOnline,
                onChanged: (value) {
                  setState(() {
                    _isOnline = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          // Placeholder for the map
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  "Map Placeholder",
                  style: TextStyle(fontSize: 22, color: Colors.black54),
                ),
              ),
            ),
          ),
          // Placeholder for current order details
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isOnline ? "Searching for orders..." : "You are offline",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _isOnline
                      ? "You will be notified when a new order is available."
                      : "Go online to start receiving orders.",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

