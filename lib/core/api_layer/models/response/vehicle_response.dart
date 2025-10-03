import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/core/api_layer/models/response/vehicle_dto.dart';

part 'vehicle_response.g.dart';

@JsonSerializable(explicitToJson: true)
class VehiclesResponse {
  final String? message;
  final Metadata? metadata;
  final List<VehicleDto>? vehicles;

  VehiclesResponse({this.message, this.metadata, this.vehicles});

  factory VehiclesResponse.fromJson(Map<String, dynamic> json) =>
      _$VehiclesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesResponseToJson(this);
}

@JsonSerializable()
class Metadata {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
