class DishModel {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  DishModel({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });
}
