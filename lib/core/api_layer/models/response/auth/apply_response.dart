import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import '../../../../../features/auth/apply/domain/entities/apply_entity.dart';

part 'apply_response.g.dart';

@JsonSerializable()
class ApplyResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "driver")
  final DriverDto? driver;
  @JsonKey(name: "token")
  final String? token;
    @JsonKey(name: "error")
  final String? error;

  ApplyResponse({this.message, this.driver, this.token, this.error});

  factory ApplyResponse.fromJson(Map<String, dynamic> json) {
    return _$ApplyResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ApplyResponseToJson(this);
  }
}

@JsonSerializable()
class DriverDto {
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? vehicleLicense;
  @JsonKey(name: "NID")
      // ignore: non_constant_identifier_names
  final String? NID;
  @JsonKey(includeFromJson: false, includeToJson: false)
      // ignore: non_constant_identifier_names
  final File? NIDImg;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  DriverDto({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
        // ignore: non_constant_identifier_names
    this.NID,
        // ignore: non_constant_identifier_names
    this.NIDImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.createdAt,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return _$DriverDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverDtoToJson(this);
  }

  DriverEntity toApplyEntity() => DriverEntity(
    firstName: firstName,
    lastName: lastName,
    email: email,
    gender: gender,
    phone: phone,
    photo: photo,
    id: id,
    country: country,
    vehicleType: vehicleType,
    vehicleNumber: vehicleNumber,
    vehicleLicense: vehicleLicense,
    nID: NID,
    nIDImg: NIDImg,
    role: role,
    createdAt: createdAt,
  );
}
