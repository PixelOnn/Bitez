import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final Timestamp createdAt;
  final String? fcmToken; // <-- ADD THIS
  final Map<String, dynamic>? deviceInfo; // <-- ADD THIS

  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.createdAt,
    this.fcmToken, // <-- ADD THIS
    this.deviceInfo, // <-- ADD THIS
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'fcmToken': fcmToken, // <-- ADD THIS
      'deviceInfo': deviceInfo, // <-- ADD THIS
    };
  }
}