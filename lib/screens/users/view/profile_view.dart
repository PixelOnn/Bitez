import 'package:bitez/screens/users/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../controller/profile_controller.dart';
import 'feedback_view.dart';
import 'offers_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController _controller = ProfileController();
  final PaymentController _paymentController = PaymentController();
  String _appVersion = '';
  String? _savedAddress;
  bool _isLoadingAddress = true;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    _loadAddress();
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion =
      'App version ${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  Future<void> _loadAddress() async {
    final address = await _paymentController.getUserAddress();
    if (mounted) {
      setState(() {
        _savedAddress = address;
        _isLoadingAddress = false;
      });
    }
  }

  Future<void> _addOrUpdateAddress() async {
    setState(() {
      _isLoadingAddress = true;
    });
    final newAddress =
    await _paymentController.fetchAndSaveCurrentUserLocation();
    if (mounted) {
      setState(() {
        _savedAddress = newAddress;
        _isLoadingAddress = false;
      });
    }
  }

  void _showLogoutConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Logout',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('No'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _controller.signOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Yes'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        // The back arrow will now appear automatically
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildListTile(
                    icon: Icons.local_offer_outlined,
                    title: "Offers",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OffersScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildListTile(
                    icon: Icons.feedback_outlined,
                    title: "Feedback",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FeedbackScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildAddressSection(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: _showLogoutConfirmationDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                ),
              ),
            ),
            const Spacer(),
            Text(
              _appVersion,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    if (_isLoadingAddress) {
      return const ListTile(
        leading: Icon(Icons.home_outlined),
        title: Text("Loading Address..."),
        subtitle: CircularProgressIndicator(),
      );
    }

    return ListTile(
      leading: const Icon(Icons.home_outlined),
      title: const Text("My Address"),
      subtitle: Text(_savedAddress ?? "No address saved."),
      trailing: ElevatedButton(
        onPressed: _addOrUpdateAddress,
        child: Text(_savedAddress == null ? "Add" : "Update"),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

