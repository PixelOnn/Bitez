import 'package:flutter/material.dart';

import 'delivery_work_location_view.dart';

class VehicleTypeView extends StatelessWidget {
  const VehicleTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Vehicle Type")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: RadioListTile(
                title: const Text("Petrol Motorcycle"),
                value: "motorcycle",
                groupValue: "motorcycle", // Only one option for now
                onChanged: (value) {},
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // In a real app, save this choice via a controller
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WorkLocationView()),
                );
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}
