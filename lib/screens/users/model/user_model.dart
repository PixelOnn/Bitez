// lib/screens/users/model/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.createdAt,
  });

  // Function to convert a UserModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
    };
  }
}