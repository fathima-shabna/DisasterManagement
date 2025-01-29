import 'dart:io';

class RegistrationModel {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String password;
  final String? vehicleNumber;
  final List<String> selectedSkills;
  final String registrationType;
  final File? profileImage;

  RegistrationModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    this.vehicleNumber,
    required this.selectedSkills,
    required this.registrationType,
    this.profileImage,
  });
}

// class Resource {
//   final String category;
//   final String name;
//   final String description;

//   Resource({
//     required this.category,
//     required this.name,
//     required this.description,
//   });
// }

