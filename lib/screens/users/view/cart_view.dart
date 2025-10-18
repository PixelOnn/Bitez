import 'package:bitez/screens/users/controller/cart_controller.dart';
import 'package:bitez/screens/users/model/restaurant_model.dart';
import 'package:bitez/screens/users/view/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    final RestaurantModel? restaurant = cartController.items.isNotEmpty
        ? cartController.items.first.dish.restaurant
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        automaticallyImplyLeading: true, // This will show the back button
      ),
      body: cartController.items.isEmpty
          ? const Center(
        child: Text("Your cart is empty.", style: TextStyle(fontSize: 18)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: cartController.items.length,
        itemBuilder: (context, index) {
          final item = cartController.items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.dish.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.dish.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        Text('₹${item.dish.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          cartController.decrementItemQuantity(item.dish.id);
                        },
                      ),
                      Text(item.quantity.toString(),
                          style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          cartController.incrementItemQuantity(item.dish.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cartController.items.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (restaurant != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentView(restaurant: restaurant),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Proceed to Checkout (₹${cartController.getTotalPrice().toStringAsFixed(2)})',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

