import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';
import 'package:tracking_app/features/profile/domain/usecases/get_logged_driver_data_use_case.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';

class MockGetLoggedDriverDataUseCase extends Mock
    implements GetLoggedDriverDataUseCase {}

void main() {
  late ProfileCubit cubit;
  late MockGetLoggedDriverDataUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetLoggedDriverDataUseCase();
    cubit = ProfileCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is ProfileInitial', () {
    expect(cubit.state, ProfileInitial());
  });

  blocTest<ProfileCubit, ProfileState>(
    'emits [GetLoggedDriverDataLoading, GetLoggedDriverDataSuccess] when getLoggedDriverData succeeds',
    build: () {
      when(mockUseCase.call()).thenAnswer(
        (_) async => ApiSuccessResult(
          ProfileDriverEntity(
            firstName: 'Marwan',
            lastName: 'Yasser',
            email: 'marwan@example.com',
            phone: '123456789',
            photo: 'photo_url',
          ),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.getLoggedDriverData(),
    expect: () => [
      GetLoggedDriverDataLoading(),
      isA<GetLoggedDriverDataSuccess>(),
    ],
    verify: (_) {
      expect(cubit.firstNameController.text, 'Marwan');
      expect(cubit.lastNameController.text, 'Yasser');
      expect(cubit.emailController.text, 'Marwan@example.com');
      expect(cubit.phoneController.text, '123456789');
      expect(cubit.photo, 'photo_url');
    },
  );

  blocTest<ProfileCubit, ProfileState>(
    'emits [GetLoggedDriverDataLoading, GetLoggedDriverDataError] when getLoggedDriverData fails',
    build: () {
      when(
        mockUseCase.call(),
      ).thenAnswer((_) async => ApiErrorResult<ProfileDriverEntity>('error'));
      return cubit;
    },
    act: (cubit) => cubit.getLoggedDriverData(),
    expect: () => [
      GetLoggedDriverDataLoading(),
      GetLoggedDriverDataError(message: 'error'),
    ],
  );
}
