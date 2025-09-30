import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/datasources/get_pending_orders_data_source.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';

@Injectable(as: GetPendingOrdersDataSource)
class GetPendingOrdersDataSourceImpl
    implements GetPendingOrdersDataSource {
  final ApiClient _apiClient;

  GetPendingOrdersDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<PendingDriverOrdersEntity>>
  getPendingDriverOrders() async {
    try {
      PendingOrdersResponse pendingOrdersResponse =
          await _apiClient.getPendingDriverOrders();

      if (pendingOrdersResponse.message == 'success') {
        return ApiSuccessResult<
          PendingDriverOrdersEntity
        >(
          pendingOrdersResponse
              .toPendingDriverOrderEntity(),
        );
      } else {
        return ApiErrorResult<PendingDriverOrdersEntity>(
          pendingOrdersResponse.message ??
              'Unknown error',
        );
      }
    } on DioException catch (e) {
      return ApiErrorResult(e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
