import 'package:bitez/screens/users/model/restaurant_model.dart';

class DishModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final RestaurantModel restaurant; // <-- ADD THIS LINE
  bool isFavorite;

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurant, // <-- ADD THIS LINE
    this.isFavorite = false,
  });
}

