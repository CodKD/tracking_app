import 'package:tracking_app/core/api_layer/api_result/api_result.dart';

import '../../data/models/request/update_order_request.dart';
import '../entities/start_order_entity.dart';
import '../entities/update_order_state_entity.dart';

abstract class OrderDetailsRepo {
  Future<ApiResult<StartOrderEntity?>> startOrder(String orderId);
  Future<ApiResult<UpdateOrderStateEntity?>> updateOrder(String orderId,UpdateOrderRequest updateOrderRequest);
}
