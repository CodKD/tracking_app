import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'apply_request.g.dart';

@JsonSerializable()
class ApplyRequest {
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
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "rePassword")
  final String? rePassword;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;

  ApplyRequest({
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
    this.password,
    this.rePassword,
    this.gender,
    this.phone,
  });

  factory ApplyRequest.fromJson(Map<String, dynamic> json) {
    return _$ApplyRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ApplyRequestToJson(this);
  }
}
