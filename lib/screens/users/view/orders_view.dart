import 'package:flutter/material.dart';

import '../model/dishes_model.dart';

class OrdersView extends StatelessWidget {
  final DishModel dish;

  const OrdersView({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dish.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  dish.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              dish.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              dish.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed successfully! (simulation)")),
                  );
                },
                child: Text("Place Order - ₹${dish.price.toStringAsFixed(2)}"),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
