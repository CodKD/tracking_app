import 'package:tracking_app/core/api_layer/api_result/api_result.dart';

import '../../domain/entities/start_order_entity.dart';
import '../../domain/entities/update_order_state_entity.dart';
import '../models/request/update_order_request.dart';

abstract class OrderDetailsDataSourcesRepo {
  Future<ApiResult<StartOrderEntity?>> startOrder(String orderId);
  Future<ApiResult<UpdateOrderStateEntity?>> updateOrder(String orderId,UpdateOrderRequest updateOrderRequest);
}
