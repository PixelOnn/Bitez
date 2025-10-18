import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final Timestamp createdAt;
  final String? fcmToken;
  final Map<String, dynamic>? deviceInfo;
  final String? address; // <-- ADD THIS

  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.createdAt,
    this.fcmToken,
    this.deviceInfo,
    this.address, // <-- ADD THIS
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'fcmToken': fcmToken,
      'deviceInfo': deviceInfo,
      'address': address, // <-- ADD THIS
    };
  }
}
