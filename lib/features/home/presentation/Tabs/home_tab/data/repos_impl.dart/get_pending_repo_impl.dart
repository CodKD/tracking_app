import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/datasources/get_pending_orders_data_source.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/repositories/get_pending_orders_repo.dart';


@Injectable(as: GetPendingOrdersRepo)
class GetPendingOrdersRepoImpl implements GetPendingOrdersRepo {
  final GetPendingOrdersDataSource dataSource;
  GetPendingOrdersRepoImpl(this.dataSource);
  @override
  Future<ApiResult<PendingDriverOrdersEntity>> getPendingDriverOrders()async {
    return await dataSource.getPendingDriverOrders();
  }
}