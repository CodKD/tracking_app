import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/features/profile/data/data_source/get_logged_driver_data_source.dart';
import 'package:tracking_app/features/profile/data/repositories/get_logged_driver_data_repo_impl.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';

class MockGetLoggedDriverDataSource extends Mock
    implements GetLoggedDriverDataSource {}

void main() {
  late MockGetLoggedDriverDataSource mockDataSource;
  late GetLoggedDriverDataRepoImpl repo;

  setUp(() {
    mockDataSource = MockGetLoggedDriverDataSource();
    repo = GetLoggedDriverDataRepoImpl(mockDataSource);
  });

  group('GetLoggedDriverDataRepoImpl', () {
    test(
      'should call getLoggedDriverData on data source and return result',
      () async {
        final tEntity = ProfileDriverEntity(); // Adjust constructor as needed
        final tResult = ApiSuccessResult(tEntity);
        when(
          mockDataSource.getLoggedDriverData(),
        ).thenAnswer((_) async => tResult);

        final result = await repo.getLoggedDriverData();

        expect(result, tResult);
        verify(mockDataSource.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}
