// dummy pay button
import 'package:bitez/screens/users/controller/cart_controller.dart';
import 'package:bitez/screens/users/controller/payment_controller.dart';
import 'package:bitez/screens/users/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatefulWidget {
  final RestaurantModel restaurant;
  const PaymentView({super.key, required this.restaurant});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final PaymentController _paymentController = PaymentController();
  String? _deliveryAddress;

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  void _fetchAddress() async {
    String? address = await _paymentController.getUserAddress();
    setState(() {
      _deliveryAddress = address ?? 'No address found';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- CUSTOM HEADER ---
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    // Icon color is now controlled by app_theme
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Payment Options',
                    // --- STYLE ADDED HERE ---
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay', // Matches your theme
                      color: Colors.black,
                      fontSize: 22, // Increased size
                      fontWeight: FontWeight.bold,
                    ),
                    // ------------------------
                  ),
                ],
              ),
            ),
            // --- END CUSTOM HEADER ---
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant and Delivery Details (Keeps white card)
                      _buildRestaurantDetails(),
                      const SizedBox(height: 16),
                      // Payment Offers (Keeps its own card style)
                      _buildPaymentOffers(),
                      const SizedBox(height: 24),
                      // UPI Options
                      _buildPaymentSectionHeader('Pay by any UPI App'),
                      _buildUpiOptions(), // <-- This is updated
                      const SizedBox(height: 24),
                      // Credit & Debit Cards
                      _buildPaymentSectionHeader('Credit & Debit Cards'),
                      _buildCardOptions(), // <-- This is updated
                      const SizedBox(height: 24),
                      // More Payment Options
                      _buildPaymentSectionHeader('More Payment Options'),
                      _buildMoreOptionsList(), // <-- This is updated
                    ],
                  ),
                ),
              ),
            ),
            // --- DUMMY PAY BUTTON ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Placeholder for real payment logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Simulating payment... Order Placed!')),
                    );
                    // In a real app, you would navigate to an order success screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'PAY ₹${cartController.getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // --- END DUMMY PAY BUTTON ---
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantDetails() {
    // This widget remains unchanged, keeping its white card
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.storefront, color: Colors.deepPurple),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  _deliveryAddress ?? 'Loading address...',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOffers() {
    // This widget remains unchanged, keeping its light green card
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.local_offer, color: Colors.green, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Save upto ₹54 more with payment offers',
              style:
              TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildPaymentSectionHeader(String title) {
    // Kept this white as it's the section header
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUpiOptions() {
    // --- UPDATED ---
    // Removed the Card widget
    return const ListTile(
      leading: Icon(Icons.add_circle_outline, color: Colors.black), // <-- color
      title: Text('Add New UPI ID',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)), // <-- style
      subtitle: Text('You need to have a registered UPI ID',
          style: TextStyle(color: Colors.black54)), // <-- style
    );
  }

  Widget _buildCardOptions() {
    // --- UPDATED ---
    // Removed the Card widget
    return const ListTile(
      leading: Icon(Icons.add_card, color: Colors.black), // <-- color
      title: Text('Add New Card',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)), // <-- style
      subtitle: Text('Save and Pay via Cards',
          style: TextStyle(color: Colors.black54)), // <-- style
    );
  }

  Widget _buildMoreOptionsList() {
    // --- UPDATED ---
    // Added dividers with a black-ish color
    return Column(
      children: [
        _buildMoreOptionItem(
            icon: Icons.account_balance_wallet,
            title: 'Wallets',
            subtitle: 'PhonePe, Amazon Pay & more'),
        Divider(color: Colors.black.withOpacity(0.2)),
        _buildMoreOptionItem(
            icon: Icons.account_balance,
            title: 'Netbanking',
            subtitle: 'Select from a list of banks'),
        Divider(color: Colors.black.withOpacity(0.2)),
        _buildMoreOptionItem(
            icon: Icons.delivery_dining,
            title: 'Pay on Delivery',
            subtitle: 'Pay in cash or pay online'),
      ],
    );
  }

  Widget _buildMoreOptionItem(
      {required IconData icon,
        required String title,
        required String subtitle}) {
    // --- UPDATED ---
    // Changed all text and icon colors to black
    return ListTile(
      leading: Icon(icon, color: Colors.black), // <-- color
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)), // <-- style
      subtitle:
      Text(subtitle, style: const TextStyle(color: Colors.black54)), // <-- style
      trailing: const Icon(Icons.arrow_forward_ios,
          size: 24, color: Colors.black), // <-- color
      onTap: () {}, // Placeholder for navigation
    );
  }
}