import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../vehicle_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_response_dto.g.dart';


@JsonSerializable()
class VehicleResponseDto extends Equatable {
  final String? message;
  final VehicleDto? vehicle;

  const VehicleResponseDto({this.message, this.vehicle});

  factory VehicleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, vehicle];
}