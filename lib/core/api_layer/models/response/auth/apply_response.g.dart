// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyResponse _$ApplyResponseFromJson(Map<String, dynamic> json) =>
    ApplyResponse(
      message: json['message'] as String?,
      driver: json['driver'] == null
          ? null
          : DriverDto.fromJson(json['driver'] as Map<String, dynamic>),
      token: json['token'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ApplyResponseToJson(ApplyResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'driver': instance.driver,
      'token': instance.token,
      'error': instance.error,
    };

DriverDto _$DriverDtoFromJson(Map<String, dynamic> json) => DriverDto(
  country: json['country'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  vehicleType: json['vehicleType'] as String?,
  vehicleNumber: json['vehicleNumber'] as String?,
  NID: json['NID'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  photo: json['photo'] as String?,
  role: json['role'] as String?,
  id: json['_id'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$DriverDtoToJson(DriverDto instance) => <String, dynamic>{
  'country': instance.country,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'vehicleType': instance.vehicleType,
  'vehicleNumber': instance.vehicleNumber,
  'NID': instance.NID,
  'email': instance.email,
  'gender': instance.gender,
  'phone': instance.phone,
  'photo': instance.photo,
  'role': instance.role,
  '_id': instance.id,
  'createdAt': instance.createdAt,
};
