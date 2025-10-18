import 'dishes_model.dart';

class CartItemModel {
  final DishModel dish;
  int quantity;

  CartItemModel({
    required this.dish,
    this.quantity = 1,
  });

  // Method to get total price for this item
  double get totalPrice => dish.price * quantity;
}
