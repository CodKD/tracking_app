import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/resources/country.dart';
import 'package:tracking_app/features/auth/apply/domain/entities/apply_entity.dart';
import 'package:tracking_app/features/auth/apply/domain/usecases/apply_use_case.dart';

part 'driver_apply_state.dart';

@injectable
class DriverApplyCubit extends Cubit<DriverApplyState> {
  DriverApplyCubit(this.applyUseCase)
    : super(DriverApplyInitial());
  final ApplyUseCase applyUseCase;

  List<Country> countries = [];
  final vehicleTypes = ['Bike', 'Car', 'Truck'];
  bool isPasswordObscureText = true;
  bool isConfirmPasswordObscureText = true;

  TextEditingController emailController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();
  TextEditingController confirmPasswordController =
      TextEditingController();
  TextEditingController firstNameController =
      TextEditingController();
  TextEditingController lastNameController =
      TextEditingController();
  TextEditingController phoneNumberController =
      TextEditingController();
  TextEditingController nIDController =
      TextEditingController();
  TextEditingController vehicleTypeController =
      TextEditingController();
  TextEditingController vehicleNumberController =
      TextEditingController();
  TextEditingController countryController =
      TextEditingController();
  TextEditingController nIDImgController =
      TextEditingController();
  TextEditingController vehicleLicenseController =
      TextEditingController();

  GlobalKey<FormState> applyFormKey =
      GlobalKey<FormState>();

  String? selectedGender;
  DriverEntity driver = DriverEntity();
  String selectedCountry = '';
  String selectedVehicleType = '';
  File? vehicleLicense;
  File? nIDImg;

  void selectCountry(String country) {
    selectedCountry = country;
    emit(DriverApplyCountrySelected(selectedCountry));
  }

  void changePasswordVisibility() {
    isPasswordObscureText = !isPasswordObscureText;
    emit(
      DriverApplyChangePasswordVisibility(
        isPasswordObscureText,
      ),
    );
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordObscureText =
        !isConfirmPasswordObscureText;
    emit(
      DriverApplyChangeConfirmPasswordVisibility(
        isConfirmPasswordObscureText,
      ),
    );
  }

  Future<File?> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return pickedFile != null
        ? File(pickedFile.path)
        : null;
    // if (pickedFile != null) {
    //   imageFile = File(pickedFile.path);
    //   emit(DriverApplyLicenseImagePicked(pickedFile.path));
    // } else {
    //   emit(DriverApplyImageError("No image selected"));
    // }
  }

  Future<void> pickNIDImage() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      nIDImg = File(pickedFile.path);
      emit(DriverApplyNIDImagePicked(pickedFile.path));
    } else {
      emit(DriverApplyImageError("No image selected"));
    }
  }

  Future<void> pickVehicleLicenseImage() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      vehicleLicense = File(pickedFile.path);
      vehicleLicenseController.text = getFileName(
        vehicleLicense!.path,
      );
      emit(
        DriverApplyLicenseImagePicked(pickedFile.path),
      );
    } else {
      emit(DriverApplyImageError("No image selected"));
    }
  }

  void clearVehicleLicense() {
    vehicleLicense = null;
    vehicleLicenseController.clear();
    emit(DriverApplyLicenseImageCleared());
  }

  void clearNIDImage() {
    nIDImg = null;
    nIDImgController.clear();
    emit(DriverApplyNIDImageCleared());
  }

  String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  void selectVehicleType(String country) {
    selectedVehicleType = country;
    emit(DriverApplyVehicleType(selectedVehicleType));
  }

  void selectGender(String gender) {
    selectedGender = gender;
    emit(DriverApplyGenderSelected(selectedGender));
  }

  void initialize() async {
    emit(DriverApplyCountryListLoading());
    countries = await Country.getSortedCountries();
    emit(DriverApplyCountryList(countries));
  }

  void apply() async {
    if (!applyFormKey.currentState!.validate()) {
      return;
    }
    emit(DriverApplyLoading());
    var result = await applyUseCase.call(
      ApplyRequest(
        email: emailController.text,
        password: passwordController.text,
        rePassword: confirmPasswordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: "+${phoneNumberController.text}",
        gender: selectedGender,
        NID: nIDController.text,
        vehicleType: selectedVehicleType.toHex(),
        vehicleNumber: vehicleNumberController.text,
        country: selectedCountry,
        NIDImg: nIDImg,
        vehicleLicense: vehicleLicense,
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
