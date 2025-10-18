import 'package:flutter/material.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Your Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter some basic details", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: "First Name")),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: "Last Name")),
            const SizedBox(height: 24),
            const Text("Select your gender", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio(value: "Male", groupValue: _gender, onChanged: (v) => setState(() => _gender=v)),
                const Text("Male"),
                Radio(value: "Female", groupValue: _gender, onChanged: (v) => setState(() => _gender=v)),
                const Text("Female"),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            const Text("Upload your documents", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            _buildDocumentUploadTile("Aadhaar Card"),
            _buildDocumentUploadTile("PAN Card"),
            _buildDocumentUploadTile("Driving License"),
            _buildDocumentUploadTile("RC Book"),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // This signals that the "Profile" step is complete
                Navigator.pop(context, true);
              },
              child: const Text("Save & Continue"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: ElevatedButton.icon(
        icon: const Icon(Icons.upload_file),
        label: const Text("Upload"),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("File upload will be implemented here.")));
        },
      ),
    );
  }
}
