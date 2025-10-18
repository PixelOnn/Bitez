import 'package:flutter/material.dart';

class WorkLocationView extends StatelessWidget {
  const WorkLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Work Area")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: RadioListTile(
                title: const Text("Kangayam"),
                subtitle: const Text("Upto ₹12,000 weekly earnings"),
                value: "Kangayam",
                groupValue: "Kangayam",
                onChanged: (value) {},
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // This signals that the "Work Settings" step is complete
                // We pop twice to get back to the DeliverySettingsView
                Navigator.pop(context, true); // Pop WorkLocationView
                Navigator.pop(context, true); // Pop VehicleTypeView
              },
              child: const Text("Confirm Location"),
            ),
          ],
        ),
      ),
    );
  }
}
