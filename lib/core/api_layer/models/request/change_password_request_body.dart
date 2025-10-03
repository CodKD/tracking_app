import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_body.g.dart';

@JsonSerializable()
class ChangePasswordRequestBody {
  final String? password;
  final String? newPassword;

  ChangePasswordRequestBody(this.password, this.newPassword);

  factory ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestBodyToJson(this);
}
