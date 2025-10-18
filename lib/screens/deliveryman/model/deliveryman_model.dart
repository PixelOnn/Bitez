import 'package:cloud_firestore/cloud_firestore.dart';

class DeliverymanModel {
  final String uid;
  final String phoneNumber;
  final String? language;
  final String? vehicleType;
  final String? workLocation;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final bool isAadhaarUploaded;
  final bool isPanUploaded;
  final bool isDrivingLicenseUploaded;
  final bool isRcBookUploaded;
  final Timestamp createdAt;

  DeliverymanModel({
    required this.uid,
    required this.phoneNumber,
    this.language,
    this.vehicleType,
    this.workLocation,
    this.firstName,
    this.lastName,
    this.gender,
    this.isAadhaarUploaded = false,
    this.isPanUploaded = false,
    this.isDrivingLicenseUploaded = false,
    this.isRcBookUploaded = false,
    required this.createdAt,
  });

  // From Firestore document to model
  factory DeliverymanModel.fromMap(Map<String, dynamic> map) {
    return DeliverymanModel(
      uid: map['uid'],
      phoneNumber: map['phoneNumber'],
      language: map['language'],
      vehicleType: map['vehicleType'],
      workLocation: map['workLocation'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      isAadhaarUploaded: map['isAadhaarUploaded'] ?? false,
      isPanUploaded: map['isPanUploaded'] ?? false,
      isDrivingLicenseUploaded: map['isDrivingLicenseUploaded'] ?? false,
      isRcBookUploaded: map['isRcBookUploaded'] ?? false,
      createdAt: map['createdAt'],
    );
  }


  // From model to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'language': language,
      'vehicleType': vehicleType,
      'workLocation': workLocation,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'isAadhaarUploaded': isAadhaarUploaded,
      'isPanUploaded': isPanUploaded,
      'isDrivingLicenseUploaded': isDrivingLicenseUploaded,
      'isRcBookUploaded': isRcBookUploaded,
      'createdAt': createdAt,
    };
  }
}
