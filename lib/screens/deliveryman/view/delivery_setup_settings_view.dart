
import 'package:flutter/material.dart';

// This is a placeholder for the final home screen
import 'delivery_home_view.dart';
import 'delivery_setup_details_view.dart';
import 'delivery_vehicle_view.dart';

class DeliverySettingsView extends StatefulWidget {
  const DeliverySettingsView({super.key});

  @override
  State<DeliverySettingsView> createState() => _DeliverySettingsViewState();
}

class _DeliverySettingsViewState extends State<DeliverySettingsView> {
  // In a real app, this data would come from your controller/Firestore
  bool _workSettingsComplete = false;
  bool _profileComplete = false;

  void _navigateToVehicleType() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VehicleTypeView()),
    );
    if (result == true) {
      setState(() {
        _workSettingsComplete = true;
      });
    }
  }

  void _navigateToProfileDetails() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileDetailsView()),
    );
    if (result == true) {
      setState(() {
        _profileComplete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become a Partner"),
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Become a delivery partner in 3 easy steps!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            _buildStepCard(
              step: 1,
              title: "Work Settings",
              isComplete: _workSettingsComplete,
              onTap: _navigateToVehicleType,
            ),
            _buildStepCard(
              step: 2,
              title: "Profile",
              subtitle: "Upload Aadhaar and PAN details",
              isComplete: _profileComplete,
              onTap: _navigateToProfileDetails,
            ),
            _buildStepCard(
              step: 3,
              title: "Order Bitez delivery kit",
              isComplete: false, // Placeholder
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This feature is coming soon!")));
              },
            ),
            const Spacer(),
            if (_workSettingsComplete && _profileComplete)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DeliveryHomeView()),
                          (route) => false);
                },
                child: const Text("Go to Home"),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required int step,
    required String title,
    String? subtitle,
    required bool isComplete,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isComplete ? Colors.green : Colors.orange,
          child: isComplete
              ? const Icon(Icons.check, color: Colors.white)
              : Text("$step", style: const TextStyle(color: Colors.white)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: isComplete
            ? const Text("Completed", style: TextStyle(color: Colors.green))
            : const Icon(Icons.arrow_forward_ios),
        onTap: isComplete ? null : onTap,
      ),
    );
  }
}
