import 'package:bitez/screens/users/view/profile_view.dart';
import 'package:bitez/screens/users/view/restaurant_card._viewdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import this for the "See All" text
import '../controller/home_controller.dart';
import 'category_item_view.dart';
import 'dummy_data_view.dart';

// --- NEW DATA MODEL FOR EMOJI CATEGORIES ---
class EmojiCategory {
  final String name;
  final String emoji;
  EmojiCategory({required this.name, required this.emoji});
}

// --- NEW DATA LISTS FOR EMOJI CATEGORIES (matching your screenshot) ---
final List<EmojiCategory> emojiCategories = [
  EmojiCategory(name: 'Hambur..', emoji: '🍔'),
  EmojiCategory(name: 'Pizza', emoji: '🍕'),
  EmojiCategory(name: 'Noodles', emoji: '🍜'),
  EmojiCategory(name: 'Meat', emoji: '🍖'),
  EmojiCategory(name: 'Vegeta..', emoji: '🥬'),
  EmojiCategory(name: 'Dessert', emoji: '🍰'),
  EmojiCategory(name: 'Drink', emoji: '🍺'),
  EmojiCategory(name: 'More', emoji: '🥮'),
];

// --- NEW FUNCTION TO GET CATEGORIES BY TIME (for the new UI) ---
// Since the data is the same for all times in your example, we'll return the same list.
// If you wanted different emojis for morning/night, you would change this function.
List<EmojiCategory> getEmojiCategoriesByTime() {
  final int hour = TimeOfDay.now().hour;
  // This data matches your screenshot and doesn't seem to change by time,
  // so we return the main list.
  // If you want it to change, create new lists like `morningEmojiCategories`
  // and return them here based on the `hour`.
  return emojiCategories;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();
  String _currentAddress = "Fetching location...";

  // This is the OLD category data for the OLD list.
  // We are replacing the OLD list, but we'll leave this here for now.
  // late final List<CategoryModel> _categories;

  // --- NEW STATE VARIABLE FOR EMOJI CATEGORIES ---
  late final List<EmojiCategory> _emojiCategories;

  @override
  void initState() {
    super.initState();
    // _categories = getCategoriesByTime(); // This is for the old list

    // --- INITIALIZE NEW EMOJI CATEGORIES ---
    _emojiCategories = getEmojiCategoriesByTime();

    _fetchLocation();
  }

  void _fetchLocation() async {
    String address = await _controller.getUserLocationAddress();
    if(mounted) {
      setState(() {
        _currentAddress = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // --- THIS IS YOUR EXISTING HEADER (UNCHANGED) ---
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1DB954), // Fixed your color code
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

          // --- 1. NEW OFFER CAROUSEL (ADDED AS REQUESTED) ---
          _buildOfferCarousel(),

          // --- 2. NEW EMOJI CATEGORY GRID (REPLACED OLD LIST) ---
          _buildEmojiCategoryGrid(),

          // --- THIS IS YOUR EXISTING DIVIDER (UNCHANGED) ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(height: 1),
          ),

          // --- THIS IS YOUR EXISTING RESTAURANT LIST (UNCHANGED) ---
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

  // --- WIDGET 1: NEW OFFER CAROUSEL ---
  Widget _buildOfferCarousel() {
    // This simple list builds your 3 dummy slides
    final List<Widget> offerSlides = [
      _buildOfferSlide(
        title: "30%",
        subtitle: "DISCOUNT ONLY\nVALID FOR TODAY!",
        color: const Color(0xFF1DB954), // Your app's green
        imagePath: 'assets/images/img.png', // <-- YOU NEED TO ADD THIS IMAGE
      ),
      _buildOfferSlide(
        title: "15%",
        subtitle: "DISCOUNT ON\nALL PIZZAS!",
        color: Colors.orangeAccent,
        imagePath: 'assets/images/pizza_image.png', // <-- YOU NEED TO ADD THIS IMAGE
      ),
      _buildOfferSlide(
        title: "Buy 1",
        subtitle: "GET 1 FREE\nON DRINKS!",
        color: Colors.blueAccent,
        imagePath: 'assets/images/drink_image.png', // <-- YOU NEED TO ADD THIS IMAGE
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          // Title row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Special Offers",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'See All',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor, // Your green
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle "See All" tap
                        print("See All Offers tapped");
                      },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Carousel
          SizedBox(
            height: 160, // Height for the carousel
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.9), // Shows part of next slide
              itemCount: offerSlides.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: offerSlides[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for a single slide in the carousel
  Widget _buildOfferSlide({
    required String title,
    required String subtitle,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              // --- THIS IS THE FIX ---
              // Changed from EdgeInsets.all(20.0) to horizontal only
              // This gives the Column full height to center the text.
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              // ---------------------
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Adjust fit as needed
                // Error builder in case you forget to add the image
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('Add Image', style: TextStyle(color: Colors.white, fontSize: 10)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET 2: NEW EMOJI CATEGORY GRID ---
  Widget _buildEmojiCategoryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 items per row
          childAspectRatio: 1.0, // Makes the items roughly square
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _emojiCategories.length,
        shrinkWrap: true, // Important for in a Column
        itemBuilder: (context, index) {
          final category = _emojiCategories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.emoji,
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }

  // --- YOUR EXISTING HEADER WIDGETS (UNCHANGED) ---
  Widget _buildLocationHeader() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.black, size: 28),
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
          icon: const Icon(Icons.person_outline, color: Colors.black, size: 28),
          onPressed: () {
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