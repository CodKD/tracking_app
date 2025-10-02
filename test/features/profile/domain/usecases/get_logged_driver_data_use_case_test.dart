import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/repositories/get_logged_driver_data_repo.dart';
import 'package:tracking_app/features/profile/domain/usecases/get_logged_driver_data_use_case.dart';

// Mock class for GetLoggedDriverDataRepo
class MockGetLoggedDriverDataRepo extends Mock
    implements GetLoggedDriverDataRepo {}

void main() {
  late GetLoggedDriverDataUseCase useCase;
  late MockGetLoggedDriverDataRepo mockRepo;

  setUp(() {
    mockRepo = MockGetLoggedDriverDataRepo();
    useCase = GetLoggedDriverDataUseCase(mockRepo);
  });

  test(
    'should return ApiResult<ProfileDriverEntity> from repository',
    () async {
      final tEntity = ProfileDriverEntity(id: '1', firstName: 'Test Driver');
      final tResult = ApiSuccessResult(tEntity);

      when(mockRepo.getLoggedDriverData()).thenAnswer((_) async => tResult);

      final result = await useCase();

      expect(result, tResult);
      verify(mockRepo.getLoggedDriverData()).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
