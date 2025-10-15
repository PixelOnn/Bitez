import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController {
  // Method to get the user's current address
  Future<String> getUserLocationAddress() async {
    // First, check for location permission
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      // If permission is denied, request it
      status = await Permission.location.request();
      if (status.isPermanentlyDenied || status.isDenied) {
        return "Location permission denied";
      }
    }

    try {
      // Get the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert the coordinates into a placemark (address details)
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Format the address nicely. You can customize this part.
        return "${place.name}, ${place.subLocality}, ${place.locality}";
      }
      return "No address found";
    } catch (e) {
      // Handle any errors, like if the GPS is turned off
      debugPrint("Error getting location: $e");
      return "Could not fetch location";
    }
  }
}