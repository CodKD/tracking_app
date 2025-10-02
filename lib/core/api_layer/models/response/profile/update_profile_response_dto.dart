import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';

part 'update_profile_response_dto.g.dart';

@JsonSerializable()
class UpdateProfileResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "driver")
  final DriverDto? driver;

  UpdateProfileResponseDto({this.message, this.driver});

  factory UpdateProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return _$UpdateProfileResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateProfileResponseDtoToJson(this);
  }

  UpdateProfileResponseEntity toEntity() {
    UpdateProfileResponseEntity updateProfileResponseEntity =
        UpdateProfileResponseEntity(
          message: message,
          driver: DriverEntity(
            id: driver?.id,
            firstName: driver?.firstName,
            lastName: driver?.lastName,
            email: driver?.email,
          ),
        );
    return updateProfileResponseEntity;
  }
}

@JsonSerializable()
class DriverDto {
  @JsonKey(name: "_id")
  final String? id;
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
  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;
  @JsonKey(name: "NID")
  final String? nID;
  @JsonKey(name: "NIDImg")
  final String? nIDImg;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  DriverDto({
    this.id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nID,
    this.nIDImg,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.createdAt,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return _$DriverDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverDtoToJson(this);
  }

  ProfileDriverEntity toGetLoggedDriverEntity() => ProfileDriverEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    gender: gender,
    phone: phone,
    photo: photo,
    role: role,
    createdAt: createdAt,
    vehicleLicense: vehicleLicense,
    nIDImg: nIDImg,
    country: country,
    nID: nID,
    vehicleNumber: vehicleNumber,
    vehicleType: vehicleType,
  );
}
