import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/profile/domain/entities/update_vehical_request_entity.dart';

part 'update_vehical_request_dto.g.dart';

@JsonSerializable()
class UpdateVehicalRequestDto {
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? vehicleLicense;

  UpdateVehicalRequestDto({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  factory UpdateVehicalRequestDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return _$UpdateVehicalRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateVehicalRequestDtoToJson(this);
  }

  UpdateVehicalRequestEntity toEntity() {
    UpdateVehicalRequestEntity
    updateVehicalRequestEntity =
    UpdateVehicalRequestEntity(
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
    );
    return updateVehicalRequestEntity;
  }

  factory UpdateVehicalRequestDto.fromEntity(
      UpdateVehicalRequestEntity updateVehicalRequestEntity,
      ) {
    return UpdateVehicalRequestDto(
      vehicleType: updateVehicalRequestEntity.vehicleType,
      vehicleNumber:
      updateVehicalRequestEntity.vehicleNumber,
      vehicleLicense:
      updateVehicalRequestEntity.vehicleLicense,
    );
  }
}
