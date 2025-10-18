import 'package:bitez/screens/users/controller/cart_controller.dart';
import 'package:bitez/screens/users/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/dishes_model.dart';
import '../model/restaurant_model.dart';
import 'dummy_data_view.dart';
import 'orders_view.dart';

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
    _dishes = dummyDishes.where((dish) => dish.restaurantId == widget.restaurant.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80), // Add padding to avoid overlap with cart banner
            itemCount: _dishes.length,
            itemBuilder: (context, index) {
              final dish = _dishes[index];
              return DishCard(
                dish: dish,
              );
            },
          ),
          Consumer<CartController>(
            builder: (context, cartController, child) {
              if (cartController.totalItemsInCart > 0) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartView()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cartController.totalItemsInCart} Item${cartController.totalItemsInCart > 1 ? 's' : ''} Added',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'View Cart • ₹${cartController.cartTotalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class DishCard extends StatelessWidget {
  final DishModel dish;

  const DishCard({
    super.key,
    required this.dish,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none, // Allow button to overflow
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  dish.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.restaurant, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                bottom: -15, // Position half-way below the image
                left: 0,
                right: 0,
                child: Center(
                  child: Consumer<CartController>(
                    builder: (context, cart, child) {
                      final quantityInCart = cart.getDishQuantityInCart(dish.id);
                      if (quantityInCart == 0) {
                        return ElevatedButton(
                          onPressed: () => cartController.addItemToCart(dish),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.green),
                            ),
                            elevation: 4,
                          ),
                          child: const Text('ADD'),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                icon: const Icon(Icons.remove, size: 20, color: Colors.green),
                                onPressed: () => cartController.decrementQuantity(dish.id),
                              ),
                              Text(
                                '$quantityInCart',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                icon: const Icon(Icons.add, size: 20, color: Colors.green),
                                onPressed: () => cartController.incrementQuantity(dish.id),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    dish.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dish.description,
                    style: TextStyle(color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    '₹${dish.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

