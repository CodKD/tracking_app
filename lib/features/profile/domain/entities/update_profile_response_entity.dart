import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';

class UpdateProfileResponseEntity {
  UpdateProfileResponseEntity({this.message, this.driver});

  String? message;
  DriverEntity? driver;
}
