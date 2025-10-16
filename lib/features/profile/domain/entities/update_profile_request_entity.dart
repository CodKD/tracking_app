import 'dart:io';

class UpdateProfileRequestEntity {
  UpdateProfileRequestEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  final String? vehicleType;
  final String? vehicleNumber;
  final File? vehicleLicense;
}
