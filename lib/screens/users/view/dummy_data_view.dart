import 'package:flutter/material.dart';
import '../model/dishes_model.dart';
import '../model/restaurant_model.dart' show RestaurantModel;

class CategoryModel {
  final String name;
  final String imageUrl;
  CategoryModel({required this.name, required this.imageUrl});
}

// Using new, stable web URLs for all category images
final List<CategoryModel> morningCategories = [
  CategoryModel(name: 'Idly', imageUrl: 'https://i.imgur.com/7s146oA.png'),
  CategoryModel(name: 'Dosa', imageUrl: 'https://i.imgur.com/DCt5a4S.png'),
  CategoryModel(name: 'Pongal', imageUrl: 'https://i.imgur.com/G5g222V.png'),
  CategoryModel(name: 'Poori', imageUrl: 'https://i.imgur.com/6a2l3vI.png'),
  CategoryModel(name: 'Vada', imageUrl: 'https://i.imgur.com/kSjYp8S.png'),
  CategoryModel(name: 'Coffee', imageUrl: 'https://i.imgur.com/8zRPiGk.png'),
];

final List<CategoryModel> afternoonCategories = [
  CategoryModel(name: 'Biryani', imageUrl: 'https://i.imgur.com/02p85Jd.png'),
  CategoryModel(name: 'Meals', imageUrl: 'https://i.imgur.com/T0i3a5A.png'),
  CategoryModel(name: 'Parotta', imageUrl: 'https://i.imgur.com/N433H8t.png'),
  CategoryModel(name: 'Fried Rice', imageUrl: 'https://i.imgur.com/4zrs5J2.png'),
  CategoryModel(name: 'Noodles', imageUrl: 'https://i.imgur.com/k5n33D2.png'),
  CategoryModel(name: 'Chicken', imageUrl: 'https://i.imgur.com/L7p2J3C.png'),
];

final List<CategoryModel> eveningCategories = [
  CategoryModel(name: 'Shawarma', imageUrl: 'https://i.imgur.com/mJ2LXpG.png'),
  CategoryModel(name: 'Pizza', imageUrl: 'https://i.imgur.com/uS3e42D.png'),
  CategoryModel(name: 'Burger', imageUrl: 'https://i.imgur.com/tC0gZ2Y.png'),
  CategoryModel(name: 'Rolls', imageUrl: 'https://i.imgur.com/O1lE6nd.png'),
  CategoryModel(name: 'Samosa', imageUrl: 'https://i.imgur.com/f2n5rv8.png'),
  CategoryModel(name: 'Pani Puri', imageUrl: 'https://i.imgur.com/391iTba.png'),
];

final List<CategoryModel> nightCategories = [
  CategoryModel(name: 'Parotta', imageUrl: 'https://i.imgur.com/N433H8t.png'),
  CategoryModel(name: 'Kothu', imageUrl: 'https://i.imgur.com/dMMsY9E.png'),
  CategoryModel(name: 'Dosa', imageUrl: 'https://i.imgur.com/DCt5a4S.png'),
  CategoryModel(name: 'Grill', imageUrl: 'https://i.imgur.com/L7p2J3C.png'),
  CategoryModel(name: 'Naan', imageUrl: 'https://i.imgur.com/vSwf583.png'),
  CategoryModel(name: 'Chapathi', imageUrl: 'https://i.imgur.com/vHru2n6.png'),
];


List<CategoryModel> getCategoriesByTime() {
  final int hour = TimeOfDay.now().hour;
  if (hour >= 6 && hour < 11) {
    return morningCategories;
  } else if (hour >= 11 && hour < 16) {
    return afternoonCategories;
  } else if (hour >= 16 && hour < 19) {
    return eveningCategories;
  } else {
    return nightCategories;
  }
}

final List<RestaurantModel> dummyRestaurants = [
  RestaurantModel(id: '1', name: 'Hotel Surya Pure Veg', imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400&q=80', cuisine: ['South Indian', 'Pure Veg', 'Dosa'], rating: 3.8, deliveryTime: '20-25 min', priceRange: '₹', address: 'Nagapattinam - Coimbatore Hwy, Kangayam'),
  RestaurantModel(id: '2', name: 'Taj Biryani', imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&q=80', cuisine: ['Biryani', 'Non-Veg', 'South Indian'], rating: 4.2, deliveryTime: '25-30 min', priceRange: '₹₹', address: 'Tiruppur Kangayam Road, Sivanmalai'),
  RestaurantModel(id: '3', name: 'Hotel Amirtha', imageUrl: 'https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?w=400&q=80', cuisine: ['Pure Veg', 'North Indian', 'Chinese'], rating: 4.5, deliveryTime: '30-35 min', priceRange: '₹₹', address: 'Dharapuram road, Near police station, Kangayam'),
  RestaurantModel(id: '4', name: 'Kavi Restaurant', imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=80', cuisine: ['South Indian', 'Chettinad'], rating: 3.7, deliveryTime: '20-25 min', priceRange: '₹', address: 'Dharapuram Road, Kangayam'),
  RestaurantModel(id: '5', name: 'Sivamalai Mess', imageUrl: 'https://content.jdmagicbox.com/comp/kangayam/c4/9999p4258.4258.180901190111.c1c4/catalogue/sivamalai-mess-andimadakkadu-kangayam-restaurants-4hcb1tx3gc.jpg', cuisine: ['Mess', 'Non-Veg', 'Local'], rating: 4.1, deliveryTime: '15-20 min', priceRange: '₹', address: 'Andimadakkadu, Kangayam'),
];

// --- NEW DUMMY DATA FOR DISHES ---
final List<DishModel> dummyDishes = [
  // Dishes for Hotel Surya (id: '1')
  DishModel(id: 'd1', restaurantId: '1', name: 'Ghee Roast Dosa', description: 'Crispy dosa roasted with pure ghee.', imageUrl: 'https://i.imgur.com/DCt5a4S.png', price: 80.0),
  DishModel(id: 'd2', restaurantId: '1', name: 'Special Pongal', description: 'Served with sambar and chutney.', imageUrl: 'https://i.imgur.com/G5g222V.png', price: 70.0),
  DishModel(id: 'd3', restaurantId: '1', name: 'Filter Coffee', description: 'Aromatic south indian filter coffee.', imageUrl: 'https://i.imgur.com/8zRPiGk.png', price: 25.0),

  // Dishes for Taj Biryani (id: '2')
  DishModel(id: 'd4', restaurantId: '2', name: 'Mutton Biryani', description: 'Authentic dum biryani with tender mutton.', imageUrl: 'https://i.imgur.com/02p85Jd.png', price: 250.0),
  DishModel(id: 'd5', restaurantId: '2', name: 'Chicken 65', description: 'Spicy and crispy fried chicken.', imageUrl: 'https://i.imgur.com/L7p2J3C.png', price: 180.0),

  // Dishes for Hotel Amirtha (id: '3')
  DishModel(id: 'd6', restaurantId: '3', name: 'Paneer Butter Masala', description: 'Creamy paneer in a rich tomato gravy.', imageUrl: 'https://i.imgur.com/vSwf583.png', price: 220.0),
  DishModel(id: 'd7', restaurantId: '3', name: 'Veg Fried Rice', description: 'Stir-fried rice with fresh vegetables.', imageUrl: 'https://i.imgur.com/4zrs5J2.png', price: 150.0),

  // Dishes for Kavi Restaurant (id: '4')
  DishModel(id: 'd8', restaurantId: '4', name: 'Chettinad Chicken', description: 'Spicy chicken curry with chettinad spices.', imageUrl: 'https://i.imgur.com/L7p2J3C.png', price: 200.0),
  DishModel(id: 'd9', restaurantId: '4', name: 'Parotta', description: 'Flaky layered flatbread.', imageUrl: 'https://i.imgur.com/N433H8t.png', price: 20.0),
];
