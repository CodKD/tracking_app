import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_dto.g.dart';
@JsonSerializable()
class VehicleDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? type;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  const VehicleDto({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDtoToJson(this);
  @override
  List<Object?> get props => [id, type, image, createdAt, updatedAt, v];
}