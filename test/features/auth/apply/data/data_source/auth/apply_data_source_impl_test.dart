import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/data_source_impl/auth/apply_data_source_impl.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/core/api_layer/models/response/auth/apply_response.dart';
import 'package:tracking_app/core/errors/failures.dart';
import 'package:tracking_app/core/keys/shared_key.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';

import 'apply_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, SharedPrefHelper])
void main() {
  late MockApiClient mockApiClient;
  late MockSharedPrefHelper mockSharedPrefHelper;
  late ApplyDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    mockSharedPrefHelper = MockSharedPrefHelper();
    dataSource = ApplyDataSourceImpl(mockApiClient, mockSharedPrefHelper);
  });

  final applyRequest = ApplyRequest(
    email: 'test@test.com',
    password: '1234',
    rePassword: '1234',
    firstName: 'Test',
    lastName: 'User',
    phone: '201234567890',
    gender: 'M',
    NID: '1234567890',
    vehicleType: 'car',
    vehicleNumber: 'ABC123',
    country: 'Egypt',
  );

  final driverResponse = DriverDto(
    id: "1",
    firstName: 'Test',
    lastName: 'User',
  );

  final applyResponse = ApplyResponse(token: 'token', driver: driverResponse);

  test('should return ApiSuccessResult when apply is successful', () async {
    // arrange
    when(
      mockApiClient.apply(
        applyRequest.email!,
        applyRequest.password!,
        applyRequest.rePassword!,
        applyRequest.firstName!,
        applyRequest.lastName!,
        applyRequest.phone!,
        applyRequest.gender!,
        applyRequest.NID!,
        applyRequest.vehicleType!,
        applyRequest.vehicleNumber!,
        applyRequest.country!,
        applyRequest.vehicleLicense,
        applyRequest.NIDImg,
      ),
    ).thenAnswer((_) async => applyResponse);

    when(
      mockSharedPrefHelper.setValue(SharedPrefKeys.tokenKey, 'token'),
    ).thenAnswer((_) async => {});

    // act
    final result = await dataSource.apply(applyRequest);

    // assert
    expect(result, isA<ApiSuccessResult<DriverEntity>>());
  });

  test('should return ApiErrorResult when apply throws error', () async {
    // arrange
    when(
      mockApiClient.apply(
        applyRequest.email!,
        applyRequest.password!,
        applyRequest.rePassword!,
        applyRequest.firstName!,
        applyRequest.lastName!,
        applyRequest.phone!,
        applyRequest.gender!,
        applyRequest.NID!,
        applyRequest.vehicleType!,
        applyRequest.vehicleNumber!,
        applyRequest.country!,
        applyRequest.vehicleLicense,
        applyRequest.NIDImg,
      ),
    ).thenThrow(ServerError(errorMessage: 'Invalid credentials'));

    // act
    final result = await dataSource.apply(applyRequest);

    // assert
    expect(result, isA<ApiErrorResult<DriverEntity>>());
  });
}
