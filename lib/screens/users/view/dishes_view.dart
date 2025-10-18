import 'package:bitez/screens/users/controller/cart_controller.dart';
import 'package:bitez/screens/users/model/dishes_model.dart';
import 'package:bitez/screens/users/model/restaurant_model.dart';
import 'package:bitez/screens/users/view/cart_view.dart';
import 'package:bitez/screens/users/view/dummy_data_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishesView extends StatefulWidget {
  final RestaurantModel restaurant;
  const DishesView({super.key, required this.restaurant});

  @override
  State<DishesView> createState() => _DishesViewState();
}

class _DishesViewState extends State<DishesView> {
  late List<DishModel> _dishes;

  @override
  void initState() {
    super.initState();
    // Correctly filter dishes by comparing the restaurant's ID
    _dishes = dummyDishes
        .where((dish) => dish.restaurant.id == widget.restaurant.id)
        .toList();
  }

  // --- NEW METHOD to show the bottom sheet ---
  void _showDishDetails(DishModel dish) {
    final cartController = Provider.of<CartController>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to be taller
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Use a Consumer to rebuild the sheet's state independently
        return Consumer<CartController>(
          builder: (context, cart, child) {
            final quantity = cart.getDishQuantityInCart(dish.id);
            return Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      dish.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dish.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${dish.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black87),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            dish.description,
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: quantity == 0
                                ? SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  cartController.addItemToCart(dish);
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14)
                                ),
                                child: const Text("ADD TO CART"),
                              ),
                            )
                                : Container(
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () =>
                                        cartController.removeItemFromCart(dish.id),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(quantity.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        cartController.addItemToCart(dish),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _dishes.length,
            padding: EdgeInsets.only(
                bottom: cartController.items.isNotEmpty ? 80 : 0),
            itemBuilder: (context, index) {
              final dish = _dishes[index];
              final quantity = cartController.getDishQuantityInCart(dish.id);

              return InkWell(
                onTap: () => _showDishDetails(dish), // <-- WRAP and CALL here
                child: Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dish.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${dish.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dish.description,
                                style: TextStyle(color: Colors.grey[600]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                dish.imageUrl,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            quantity == 0
                                ? OutlinedButton(
                              onPressed: () {
                                cartController.addItemToCart(dish);
                              },
                              child: const Text("ADD"),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, size: 18),
                                    onPressed: () => cartController
                                        .removeItemFromCart(dish.id),
                                  ),
                                  Text(quantity.toString(),
                                      style:
                                      const TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(Icons.add, size: 18),
                                    onPressed: () => cartController
                                        .addItemToCart(dish),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (cartController.items.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.green[700],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${cartController.totalItemsInCart} item added",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const CartView()));
                      },
                      child: const Row(
                        children: [
                          Text(
                            "VIEW CART",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.shopping_cart, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

