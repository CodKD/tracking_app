

import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';

abstract class MyOrdersRepo {
  Future<ApiResult<MyOrdersEntity>> getMyOrders();
}
