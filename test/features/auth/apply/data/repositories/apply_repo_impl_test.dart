import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/data/repositories/apply_repo_impl.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/data/data_source/contract/apply_data_source.dart';

class MockApplyDataSource extends Mock implements ApplyDataSource {}

class FakeApplyRequest extends Fake implements ApplyRequest {}

void main() {
  late MockApplyDataSource mockDataSource;
  late ApplyRepoImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeApplyRequest());
  });

  setUp(() {
    mockDataSource = MockApplyDataSource();
    repository = ApplyRepoImpl(mockDataSource);
  });

  final applyRequest = ApplyRequest(email: 'test@test.com', password: '1234');

  final driverEntity = DriverEntity(
    id: "1",
    firstName: "Test",
    lastName: "User",
  );

  group('ApplyRepoImpl', () {
    test(
      'should return ApiSuccessResult when datasource returns success',
      () async {
        // arrange
        when(
          () => mockDataSource.apply(applyRequest),
        ).thenAnswer((_) async => ApiSuccessResult(driverEntity));

        // act
        final result = await repository.apply(applyRequest);

        // assert
        expect(result, isA<ApiSuccessResult<DriverEntity>>());
        verify(() => mockDataSource.apply(applyRequest)).called(1);
      },
    );

    test(
      'should return ApiErrorResult when datasource returns error',
      () async {
        // arrange
        when(
          () => mockDataSource.apply(applyRequest),
        ).thenAnswer((_) async => ApiErrorResult("Some error"));

        // act
        final result = await repository.apply(applyRequest);

        // assert
        expect(result, isA<ApiErrorResult<DriverEntity>>());
        verify(() => mockDataSource.apply(applyRequest)).called(1);
      },
    );
  });
}
