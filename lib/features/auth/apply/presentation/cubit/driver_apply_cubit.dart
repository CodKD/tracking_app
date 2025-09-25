import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/usecases/apply_use_case.dart';

part 'driver_apply_state.dart';

@injectable
class DriverApplyCubit extends Cubit<DriverApplyState> {
  DriverApplyCubit(this.applyUseCase) : super(DriverApplyInitial());
  final ApplyUseCase applyUseCase;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nIDController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController nIDImgController = TextEditingController();
  TextEditingController vehicleLicenseController = TextEditingController();

  GlobalKey<FormState> applyFormKey = GlobalKey<FormState>();

  String selectedGender = '';
  DriverEntity driver = DriverEntity();
  String selectedCountry = '';
  String selectedVehicleType = '';
  File? pickedImage;

  void selectCountry(String country) {
    selectedCountry = country;
    emit(DriverApplyCountrySelected(selectedCountry));
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      emit(DriverApplyImagePicked(pickedFile.path));
    } else {
      emit(DriverApplyImageError("No image selected"));
    }
  }

  void selectVehicleType(String country) {
    selectedVehicleType = country;
    emit(DriverApplyVehicleType(selectedVehicleType));
  }

  void selectGender(String gender) {
    selectedGender = gender;
    emit(DriverApplyGenderSelected(selectedGender));
  }

  void apply() async {
    emit(DriverApplyLoading());
    var result = await applyUseCase.call(
      ApplyRequest(
        email: emailController.text,
        password: passwordController.text,
        rePassword: confirmPasswordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneNumberController.text,
        gender: selectedGender,
        nID: nIDController.text,
        vehicleType: vehicleTypeController.text,
        vehicleNumber: vehicleNumberController.text,
        country: countryController.text,
        nIDImg: nIDImgController.text,
        vehicleLicense: vehicleLicenseController.text,
      ),
    );

    switch (result) {
      case ApiSuccessResult<DriverEntity>():
        emit(DriverApplySuccess(result.data));

        break;
      case ApiErrorResult<DriverEntity>():
        emit(DriverApplyError(result.errorMessage));
        break;
    }
  }
}
