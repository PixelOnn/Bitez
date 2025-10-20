import 'dart:async'; // For the Timer
import 'package:bitez/screens/users/view/profile_view.dart';
import 'package:bitez/screens/users/view/restaurant_card._viewdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../controller/home_controller.dart';
import 'category_item_view.dart';
import 'dummy_data_view.dart';

// --- (Data models and functions remain unchanged) ---
class EmojiCategory {
  final String name;
  final String emoji;
  EmojiCategory({required this.name, required this.emoji});
}

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

List<EmojiCategory> getEmojiCategoriesByTime() {
  final int hour = TimeOfDay.now().hour;
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
  late final List<EmojiCategory> _emojiCategories;

  // --- UPDATED STATE FOR CAROUSEL ---
  late PageController _pageController;
  Timer? _offerCarouselTimer;
  final int _numOfferSlides = 3; // We have 3 hardcoded slides

  // Set a large initial page number to allow for "infinite" right scrolling
  // 50001 % 3 = 0, so it starts on the first slide.
  static const int _initialPage = 50001;
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    _emojiCategories = getEmojiCategoriesByTime();
    _fetchLocation();

    // --- INITIALIZE CAROUSEL CONTROLLER WITH NEW INITIAL PAGE ---
    _pageController = PageController(
      viewportFraction: 0.9,
      initialPage: _initialPage,
    );
    _startOfferCarouselTimer();
    // ----------------------------------------------------------
  }

  // --- UPDATED METHOD TO START THE TIMER ---
  void _startOfferCarouselTimer() {
    _offerCarouselTimer?.cancel(); // Cancel any existing timer
    _offerCarouselTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        // Just increment the page. The PageView.builder will handle the loop.
        int nextPage = (_pageController.page?.round() ?? 0) + 1;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut, // This curve provides a smooth slide
        );
      }
    });
  }
  // -----------------------------------------

  @override
  void dispose() {
    _offerCarouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
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
          // --- (Header remains unchanged) ---
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1DB954),
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

          // --- 1. OFFER CAROUSEL (NOW INFINITE-SCROLLING) ---
          _buildOfferCarousel(),

          // --- (Other widgets remain unchanged) ---
          _buildEmojiCategoryGrid(),
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

  // --- WIDGET 1: UPDATED OFFER CAROUSEL ---
  Widget _buildOfferCarousel() {
    final List<Widget> offerSlides = [
      _buildOfferSlide(
        title: "30%",
        subtitle: "DISCOUNT ONLY\nVALID FOR TODAY!",
        color: const Color(0xFF1DB954),
        imagePath: 'assets/images/img.png',
      ),
      _buildOfferSlide(
        title: "15%",
        subtitle: "DISCOUNT ON\nALL PIZZAS!",
        color: Colors.orangeAccent,
        imagePath: 'assets/images/pizza_image.png',
      ),
      _buildOfferSlide(
        title: "Buy 1",
        subtitle: "GET 1 FREE\nON DRINKS!",
        color: Colors.blueAccent,
        imagePath: 'assets/images/drink_image.png',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          // (Title row remains unchanged)
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
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("See All Offers tapped");
                      },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // --- UPDATED CAROUSEL WIDGET ---
          SizedBox(
            height: 160,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  _offerCarouselTimer?.cancel(); // Stop timer on manual drag
                } else if (notification is ScrollEndNotification) {
                  _startOfferCarouselTimer(); // Restart timer after drag
                }
                return true;
              },
              child: PageView.builder(
                controller: _pageController,
                // REMOVED itemCount to make it infinite
                itemBuilder: (context, index) {
                  // Use modulo operator to loop through the 3 slides
                  final int effectiveIndex = index % _numOfferSlides;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: offerSlides[effectiveIndex],
                  );
                },
              ),
            ),
          ),
          // ---------------------------------
        ],
      ),
    );
  }

  // --- (Offer slide helper remains unchanged) ---
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                fit: BoxFit.contain,
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

  // --- (Emoji grid remains unchanged) ---
  Widget _buildEmojiCategoryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _emojiCategories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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

  // --- (Header widgets remain unchanged) ---
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