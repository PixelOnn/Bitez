import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class PaymentController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getUserAddress() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('Users').doc(user.uid).get();
      return doc.data()?['address'];
    }
    return null;
  }

  Future<String?> fetchAndSaveCurrentUserLocation() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}";
        await _firestore
            .collection('Users')
            .doc(user.uid)
            .update({'address': address});
        return address;
      }
    } catch (e) {
      // Handle exceptions
      print(e);
    }
    return null;
  }

  Future fetchAndSetUserLocation() async {}
}
