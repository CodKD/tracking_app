import 'package:injectable/injectable.dart';
import 'package:tracking_app/features/profile/data/data_source/get_logged_driver_data_source.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/repositories/get_logged_driver_data_repo.dart';

import '../../../../core/api_layer/api_result/api_result.dart';

@Injectable(as: GetLoggedDriverDataRepo)
class GetLoggedDriverDataRepoImpl implements GetLoggedDriverDataRepo {
  GetLoggedDriverDataSource getLoggedDriverDataSource;

  GetLoggedDriverDataRepoImpl(this.getLoggedDriverDataSource);

  @override
  Future<ApiResult<ProfileDriverEntity>> getLoggedDriverData() async {
    return await getLoggedDriverDataSource.getLoggedDriverData();
  }
}
