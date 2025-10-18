import 'package:bitez/screens/users/view/profile_view.dart';
import 'package:bitez/screens/users/view/restaurant_card._viewdart.dart';
import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import 'category_item_view.dart';
import 'dummy_data_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();
  String _currentAddress = "Fetching location...";
  late final List<CategoryModel> _categories;

  @override
  void initState() {
    super.initState();
    _categories = getCategoriesByTime();
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
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryItem(category: _categories[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 1),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
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
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.white, size: 28),
          onPressed: () {
            // Navigate to the ProfileView, but without adding it to the BottomNavBar
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileView()),
            );
          },
        ),
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

