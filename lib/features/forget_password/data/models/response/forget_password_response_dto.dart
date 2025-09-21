import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/forget_password/domain/entities/forget_password_response_entity.dart';

part 'forget_password_response_dto.g.dart';

@JsonSerializable()
class ForgetPasswordResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ForgetPasswordResponseDto({this.message, this.info});

  factory ForgetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordResponseDtoToJson(this);
  }

  ForgetPasswordResponseEntity toEntity() {
    ForgetPasswordResponseEntity forgetPasswordResponseEntity =
        ForgetPasswordResponseEntity(message: message, info: info);
    return forgetPasswordResponseEntity;
  }
}
