import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/usecases/apply_use_case.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';

// ---- Mock ----
class MockApplyUseCase extends Mock implements ApplyUseCase {}

void main() {
  late DriverApplyCubit cubit;
  late MockApplyUseCase mockApplyUseCase;

  setUp(() {
    mockApplyUseCase = MockApplyUseCase();
    cubit = DriverApplyCubit(mockApplyUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('DriverApplyCubit', () {
    test('initial state should be DriverApplyInitial', () {
      expect(cubit.state, isA<DriverApplyInitial>());
    });

    blocTest<DriverApplyCubit, DriverApplyState>(
      'emits DriverApplyGenderSelected when selectGender is called',
      build: () => cubit,
      act: (cubit) => cubit.selectGender('male'),
      expect: () => [isA<DriverApplyGenderSelected>()],
    );

    blocTest<DriverApplyCubit, DriverApplyState>(
      'emits DriverApplyVehicleType when selectVehicleType is called',
      build: () => cubit,
      act: (cubit) => cubit.selectVehicleType('Car'),
      expect: () => [isA<DriverApplyVehicleType>()],
    );

    blocTest<DriverApplyCubit, DriverApplyState>(
      'emits DriverApplyChangePasswordVisibility when changePasswordVisibility is called',
      build: () => cubit,
      act: (cubit) => cubit.changePasswordVisibility(),
      expect: () => [isA<DriverApplyChangePasswordVisibility>()],
    );

    blocTest<DriverApplyCubit, DriverApplyState>(
      'emits DriverApplyChangeConfirmPasswordVisibility when changeConfirmPasswordVisibility is called',
      build: () => cubit,
      act: (cubit) => cubit.changeConfirmPasswordVisibility(),
      expect: () => [isA<DriverApplyChangeConfirmPasswordVisibility>()],
    );

    blocTest<DriverApplyCubit, DriverApplyState>(
      'emits DriverApplySuccess when apply returns success',
      build: () {
        when(mockApplyUseCase.call(ApplyRequest())).thenAnswer(
          (_) async => ApiSuccessResult(
            DriverEntity(id: '1', firstName: 'Test', lastName: 'User'),
          ),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.emailController.text = 'test@test.com';
        cubit.passwordController.text = '1234';
        cubit.confirmPasswordController.text = '1234';
        cubit.firstNameController.text = 'Test';
        cubit.lastNameController.text = 'User';
        cubit.phoneNumberController.text = '201234567890';
        cubit.nIDController.text = '1234567890';
        cubit.vehicleNumberController.text = 'ABC123';
        cubit.selectedCountry = 'Egypt';
        cubit.selectedGender = 'M';
        cubit.selectedVehicleType = 'Car';
        return cubit.apply();
      },
      expect: () => [isA<DriverApplyLoading>(), isA<DriverApplySuccess>()],
    );

    blocTest<DriverApplyCubit, DriverApplyState>(
      'emits DriverApplyError when apply returns error',
      build: () {
        when(
          mockApplyUseCase.call(ApplyRequest()),
        ).thenAnswer((_) async => ApiErrorResult("Some error"));
        return cubit;
      },
      act: (cubit) {
        cubit.emailController.text = 'bad@test.com';
        cubit.passwordController.text = '1234';
        cubit.confirmPasswordController.text = '1234';
        return cubit.apply();
      },
      expect: () => [isA<DriverApplyLoading>(), isA<DriverApplyError>()],
    );

    test('getFileName should return last segment of path', () {
      const path = '/user/home/file.png';
      final result = cubit.getFileName(path);
      expect(result, 'file.png');
    });

    test('clearVehicleLicense should reset file and controller', () {
      cubit.vehicleLicenseController.text = 'license.png';
      cubit.vehicleLicense = File('license.png');

      cubit.clearVehicleLicense();

      expect(cubit.vehicleLicense, isNull);
      expect(cubit.vehicleLicenseController.text, isEmpty);
    });

    test('clearNIDImage should reset file and controller', () {
      cubit.nIDImgController.text = 'nid.png';
      cubit.nIDImg = File('nid.png');

      cubit.clearNIDImage();

      expect(cubit.nIDImg, isNull);
      expect(cubit.nIDImgController.text, isEmpty);
    });
  });
}
