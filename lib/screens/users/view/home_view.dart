import 'package:bitez/screens/users/view/restaurant_card._viewdart.dart';
import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import 'category_item.dart';
import 'dummy_data_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();
  String _currentAddress = "Fetching location...";
  late final List<CategoryModel> _categories; // <-- New list for categories

  @override
  void initState() {
    super.initState();
    _categories = getCategoriesByTime(); // <-- Get categories based on time
    _fetchLocation();
  }

  void _fetchLocation() async {
    String address = await _controller.getUserLocationAddress();
    setState(() {
      _currentAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppBar container remains the same
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _buildLocationHeader(),
                const SizedBox(height: 16),
                _buildSearchBar(),
              ],
            ),
          ),

          // --- NEW CATEGORY LIST ---
          SizedBox(
            height: 130, // Give the horizontal list a fixed height
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // This makes it scroll left-to-right
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryItem(category: _categories[index]);
              },
            ),
          ),
          // --------------------------

          // Divider for clean separation
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 1),
          ),

          // Restaurant list remains the same
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8), // Add padding at the top
              itemCount: dummyRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(restaurant: dummyRestaurants[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ... _buildLocationHeader() and _buildSearchBar() methods are unchanged ...
  Widget _buildLocationHeader() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.white, size: 28),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentAddress.split(',').first,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (_currentAddress.contains(','))
                Text(
                  _currentAddress.substring(_currentAddress.indexOf(',') + 1).trim(),
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, color: Colors.white),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for 'Pizza'",
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: const Icon(Icons.mic, color: Colors.orange),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}