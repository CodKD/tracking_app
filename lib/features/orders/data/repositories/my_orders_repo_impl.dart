import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/data/data_sources/my_orders_online_data_source.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';

import '../../domain/repositories/my_orders_repo.dart';

@Injectable(as: MyOrdersRepo)
class MyOrdersRepoImpl implements MyOrdersRepo {
  MyOrdersOnlineDataSource myOrdersOnlineDataSource;

  MyOrdersRepoImpl(this.myOrdersOnlineDataSource);

  @override
  Future<ApiResult<MyOrdersEntity>> getMyOrders() {
    return myOrdersOnlineDataSource.getMyOrders();
  }
}
