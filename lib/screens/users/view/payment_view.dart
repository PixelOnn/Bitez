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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Payment Options',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                      // Restaurant and Delivery Details
                      _buildRestaurantDetails(),
                      const SizedBox(height: 16),
                      // Payment Offers
                      _buildPaymentOffers(),
                      const SizedBox(height: 24),
                      // UPI Options
                      _buildPaymentSectionHeader('Pay by any UPI App'),
                      _buildUpiOptions(),
                      const SizedBox(height: 24),
                      // Credit & Debit Cards
                      _buildPaymentSectionHeader('Credit & Debit Cards'),
                      _buildCardOptions(),
                      const SizedBox(height: 24),
                      // More Payment Options
                      _buildPaymentSectionHeader('More Payment Options'),
                      _buildMoreOptionsList(),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUpiOptions() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: const ListTile(
        leading: Icon(Icons.add_circle_outline, color: Colors.blue),
        title: Text('Add New UPI ID'),
        subtitle: Text('You need to have a registered UPI ID'),
      ),
    );
  }

  Widget _buildCardOptions() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: const ListTile(
        leading: Icon(Icons.add_card, color: Colors.orange),
        title: Text('Add New Card'),
        subtitle: Text('Save and Pay via Cards'),
      ),
    );
  }

  Widget _buildMoreOptionsList() {
    return Column(
      children: [
        _buildMoreOptionItem(
            icon: Icons.account_balance_wallet,
            title: 'Wallets',
            subtitle: 'PhonePe, Amazon Pay & more'),
        const Divider(),
        _buildMoreOptionItem(
            icon: Icons.account_balance,
            title: 'Netbanking',
            subtitle: 'Select from a list of banks'),
        const Divider(),
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
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {}, // Placeholder for navigation
    );
  }
}










// import 'package:bitez/screens/users/controller/cart_controller.dart';
// import 'package:bitez/screens/users/controller/payment_controller.dart';
// import 'package:bitez/screens/users/model/restaurant_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class PaymentView extends StatefulWidget {
//   final RestaurantModel restaurant;
//   const PaymentView({super.key, required this.restaurant});
//
//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }
//
// class _PaymentViewState extends State<PaymentView> {
//   final PaymentController _paymentController = PaymentController();
//   String? _deliveryAddress;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAddress();
//   }
//
//   void _fetchAddress() async {
//     String? address = await _paymentController.getUserAddress();
//     setState(() {
//       _deliveryAddress = address ?? 'No address found';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cartController = context.watch<CartController>();
//
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // --- CUSTOM HEADER ---
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                   const SizedBox(width: 16),
//                   const Text(
//                     'Payment Options',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // --- END CUSTOM HEADER ---
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Restaurant and Delivery Details
//                       _buildRestaurantDetails(),
//                       const SizedBox(height: 16),
//                       // Payment Offers
//                       _buildPaymentOffers(),
//                       const SizedBox(height: 24),
//                       // UPI Options
//                       _buildPaymentSectionHeader('Pay by any UPI App'),
//                       _buildUpiOptions(),
//                       const SizedBox(height: 24),
//                       // Credit & Debit Cards
//                       _buildPaymentSectionHeader('Credit & Debit Cards'),
//                       _buildCardOptions(),
//                       const SizedBox(height: 24),
//                       // More Payment Options
//                       _buildPaymentSectionHeader('More Payment Options'),
//                       _buildMoreOptionsList(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRestaurantDetails() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.storefront, color: Colors.deepPurple),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.restaurant.name,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   _deliveryAddress ?? 'Loading address...',
//                   style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentOffers() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.green[50],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: const Row(
//         children: [
//           Icon(Icons.local_offer, color: Colors.green, size: 20),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'Save upto ₹54 more with payment offers',
//               style: TextStyle(
//                   color: Colors.green, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget _buildUpiOptions() {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: const ListTile(
//         leading: Icon(Icons.add_circle_outline, color: Colors.blue),
//         title: Text('Add New UPI ID'),
//         subtitle: Text('You need to have a registered UPI ID'),
//       ),
//     );
//   }
//
//   Widget _buildCardOptions() {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: const ListTile(
//         leading: Icon(Icons.add_card, color: Colors.orange),
//         title: Text('Add New Card'),
//         subtitle: Text('Save and Pay via Cards'),
//       ),
//     );
//   }
//
//   Widget _buildMoreOptionsList() {
//     return Column(
//       children: [
//         _buildMoreOptionItem(
//             icon: Icons.account_balance_wallet,
//             title: 'Wallets',
//             subtitle: 'PhonePe, Amazon Pay & more'),
//         const Divider(),
//         _buildMoreOptionItem(
//             icon: Icons.account_balance,
//             title: 'Netbanking',
//             subtitle: 'Select from a list of banks'),
//         const Divider(),
//         _buildMoreOptionItem(
//             icon: Icons.delivery_dining,
//             title: 'Pay on Delivery',
//             subtitle: 'Pay in cash or pay online'),
//       ],
//     );
//   }
//
//   Widget _buildMoreOptionItem(
//       {required IconData icon,
//         required String title,
//         required String subtitle}) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.grey[700]),
//       title: Text(title),
//       subtitle: Text(subtitle),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: () {}, // Placeholder for navigation
//     );
//   }
// }
//
