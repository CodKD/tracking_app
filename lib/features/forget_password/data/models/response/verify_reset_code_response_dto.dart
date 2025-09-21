import 'package:json_annotation/json_annotation.dart';
import 'package:tracking_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';

part 'verify_reset_code_response_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeResponseDto {
  @JsonKey(name: "status")
  final String? status;

  VerifyResetCodeResponseDto({this.status});

  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) {
    return _$VerifyResetCodeResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyResetCodeResponseDtoToJson(this);
  }

  VerifyResetCodeResponseEntity toEntity() {
    VerifyResetCodeResponseEntity verifyResetCodeResponseEntity =
        VerifyResetCodeResponseEntity(status: status);
    return verifyResetCodeResponseEntity;
  }
}
