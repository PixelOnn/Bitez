
import 'package:flutter/material.dart';

import '../model/cart_items_model.dart';
import '../model/dishes_model.dart';

class CartController with ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  // Calculates the total number of items for the badge
  int get totalItemsInCart {
    int totalItems = 0;
    for (var item in _items) {
      totalItems += item.quantity;
    }
    return totalItems;
  }

  // --- NEW METHOD TO FIX THE ERROR ---
  // Calculates the total price for the payment button
  double getTotalPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += item.dish.price * item.quantity;
    }
    return total;
  }
  // ------------------------------------

  // Gets the quantity of a specific dish
  int getDishQuantityInCart(String dishId) {
    try {
      return _items.firstWhere((item) => item.dish.id == dishId).quantity;
    } catch (e) {
      return 0;
    }
  }

  // Adds an item to the cart or increases its quantity
  void addItemToCart(DishModel dish) {
    int existingIndex = _items.indexWhere((item) => item.dish.id == dish.id);
    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItemModel(dish: dish));
    }
    notifyListeners();
  }

  // Decreases an item's quantity or removes it
  void removeItemFromCart(String dishId) {
    int existingIndex = _items.indexWhere((item) => item.dish.id == dishId);
    if (existingIndex != -1) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // Increases an item's quantity
  void incrementItemQuantity(String dishId) {
    int existingIndex = _items.indexWhere((item) => item.dish.id == dishId);
    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
      notifyListeners();
    }
  }

  // Decreases an item's quantity (same as removeItemFromCart)
  void decrementItemQuantity(String dishId) {
    removeItemFromCart(dishId);
  }

  // Clears the entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

