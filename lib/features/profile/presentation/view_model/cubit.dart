import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/usecases/get_logged_driver_data_use_case.dart';

part 'states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getLoggedUserDataUseCase) : super(ProfileInitial());

  // handle data
  GetLoggedDriverDataUseCase getLoggedUserDataUseCase;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? selectedImageFile;
  String photo = '';
  final ImagePicker _picker = ImagePicker();

  void initializeWithUser(ProfileDriverEntity? driver) {
    if (driver != null) {
      firstNameController.text = driver.firstName ?? '';
      lastNameController.text = driver.lastName ?? '';
      emailController.text = driver.email ?? '';
      phoneController.text = driver.phone ?? '';
      photo = driver.photo ?? '';
      emit(GetLoggedDriverDataSuccess(driver: driver));
    }
  }

  Future<void> getLoggedDriverData() async {
    emit(GetLoggedDriverDataLoading());
    final result = await getLoggedUserDataUseCase.call();
    switch (result) {
      case ApiSuccessResult<ProfileDriverEntity>():
        emit(GetLoggedDriverDataSuccess(driver: result.data));
        firstNameController.text = result.data.firstName ?? '';
        lastNameController.text = result.data.lastName ?? '';
        emailController.text = result.data.email ?? '';
        phoneController.text = result.data.phone ?? '';
        photo = result.data.photo ?? '';
        break;

      case ApiErrorResult<ProfileDriverEntity>():
        emit(GetLoggedDriverDataError(message: result.errorMessage));
        break;
    }
  }
}
