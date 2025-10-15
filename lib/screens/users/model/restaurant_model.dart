class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> cuisine;
  final double rating;
  final String deliveryTime;
  final String priceRange;
  final String address;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.priceRange,
    required this.address,
  });
}