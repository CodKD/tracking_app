import 'package:tracking_app/features/profile/domain/entities/update_photo_response_entity.dart';

class UpdatePhotoResponseDto {
  UpdatePhotoResponseDto({this.message});

  UpdatePhotoResponseDto.fromJson(dynamic json) {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

  factory UpdatePhotoResponseDto.fromEntity(UpdatePhotoResponseEntity entity) {
    return UpdatePhotoResponseDto(message: entity.message);
  }

  UpdatePhotoResponseEntity toEntity() {
    return UpdatePhotoResponseEntity(message: message);
  }
}
