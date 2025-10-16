import 'dart:io';

class UpdateVehicalRequestEntity {
  UpdateVehicalRequestEntity({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  String? vehicleType;
  String? vehicleNumber;
  File? vehicleLicense;
}
