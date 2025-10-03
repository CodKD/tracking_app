import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'updat_vehicle_info_request.g.dart';
@JsonSerializable()
class UpdateVehicleRequestDto {
  final String? vehicleType;
  final String? vehicleNumber;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? vehicleLicense;

  UpdateVehicleRequestDto({
    required this.vehicleType,
    required this.vehicleNumber,
    this.vehicleLicense,
  });
  factory UpdateVehicleRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateVehicleRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateVehicleRequestDtoToJson(this);
  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (vehicleLicense != null)
        "vehicleLicense": await MultipartFile.fromFile(vehicleLicense!.path),
    });
  }
}
