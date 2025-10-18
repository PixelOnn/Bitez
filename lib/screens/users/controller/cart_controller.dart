import 'package:flutter/material.dart';
import '../model/cart_items_model.dart';
import '../model/dishes_model.dart';

class CartController extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => List.unmodifiable(_cartItems);

  int get totalItemsInCart => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItemToCart(DishModel dish) {
    int existingIndex = _cartItems.indexWhere((item) => item.dish.id == dish.id);

    if (existingIndex != -1) {
      // If dish already exists, increment quantity
      _cartItems[existingIndex].quantity++;
    } else {
      // If new dish, add to cart
      _cartItems.add(CartItemModel(dish: dish, quantity: 1));
    }
    notifyListeners();
  }

  void incrementQuantity(String dishId) {
    int index = _cartItems.indexWhere((item) => item.dish.id == dishId);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String dishId) {
    int index = _cartItems.indexWhere((item) => item.dish.id == dishId);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        // If quantity is 1, remove item from cart
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItemFromCart(String dishId) {
    _cartItems.removeWhere((item) => item.dish.id == dishId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Helper to check if a dish is in the cart and get its quantity
  int getDishQuantityInCart(String dishId) {
    final item = _cartItems.firstWhereOrNull((item) => item.dish.id == dishId);
    return item?.quantity ?? 0;
  }
}

// Extension to add firstWhereOrNull (similar to Kotlin's find)
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
