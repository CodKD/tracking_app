import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/data_source_impl/profile/get_logged_driver_data_source_impl.dart';
import 'package:tracking_app/core/api_layer/models/response/profile/get_logged_driver.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:dio/dio.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockGetLoggedDriver extends Mock implements GetLoggedDriver {}

class MockProfileDriver extends Mock implements DriverDto {}

void main() {
  late MockApiClient mockApiClient;
  late GetLoggedDriverDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = GetLoggedDriverDataSourceImpl(mockApiClient);
  });

  test('returns ApiSuccessResult when apiClient returns data', () async {
    final mockResponse = MockGetLoggedDriver();
    final mockDriver = MockProfileDriver();
    when(mockResponse.driver).thenReturn(mockDriver as DriverDto?);
    when(
      mockDriver.toGetLoggedDriverEntity(),
    ).thenReturn(ProfileDriverEntity(id: '1', firstName: 'Test'));
    when(
      mockApiClient.getLoggedUserData(),
    ).thenAnswer((_) async => mockResponse);

    final result = await dataSource.getLoggedDriverData();

    expect(result, isA<ApiSuccessResult<ProfileDriverEntity>>());
  });

  test('returns ApiErrorResult with message from DioException', () async {
    final dioException = DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        data: {'message': 'Test error'},
      ),
    );
    when(mockApiClient.getLoggedUserData()).thenThrow(dioException);

    final result = await dataSource.getLoggedDriverData();

    expect(result, isA<ApiErrorResult<ProfileDriverEntity>>());
    expect((result as ApiErrorResult).errorMessage, 'Test error');
  });

  test('returns ApiErrorResult with exception message', () async {
    when(mockApiClient.getLoggedUserData()).thenThrow(Exception('Other error'));

    final result = await dataSource.getLoggedDriverData();

    expect(result, isA<ApiErrorResult<ProfileDriverEntity>>());
    expect((result as ApiErrorResult).errorMessage, contains('Other error'));
  });
}
