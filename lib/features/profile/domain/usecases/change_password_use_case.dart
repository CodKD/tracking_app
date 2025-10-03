import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/change_password_entity.dart';

import '../../../../core/api_layer/models/request/change_password_request_body.dart';
import '../repositories/change_password_repo.dart';

@injectable
class ChangePasswordUseCase {
  ChangPasswordRepo changPasswordRepo;

  ChangePasswordUseCase(this.changPasswordRepo);

  Future<ApiResult<ChangePasswordEntity>> call(
    ChangePasswordRequestBody body,
  ) async {
    final result = await changPasswordRepo.changPassword(body);
    return result;
  }
}
