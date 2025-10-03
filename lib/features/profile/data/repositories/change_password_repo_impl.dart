import 'package:injectable/injectable.dart';

import '../../../../core/api_layer/api_result/api_result.dart';
import '../../../../core/api_layer/models/request/change_password_request_body.dart';
import '../../domain/entities/change_password_entity.dart';
import '../../domain/repositories/change_password_repo.dart';
import '../data_source/change_password_remote_data_source.dart';

@Injectable(as: ChangPasswordRepo)
class ChangPasswordRepoImpl implements ChangPasswordRepo {
  ChangePasswordRemoteDataSource changePasswordRemoteDataSource;

  ChangPasswordRepoImpl(this.changePasswordRemoteDataSource);

  @override
  Future<ApiResult<ChangePasswordEntity>> changPassword(
    ChangePasswordRequestBody body,
  ) async {
    return await changePasswordRemoteDataSource.changPassword(body);
  }
}
