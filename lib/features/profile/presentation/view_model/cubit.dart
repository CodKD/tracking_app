import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/features/profile/domain/entities/get_logged_driver_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_photo_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_request_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_profile_response_entity.dart';
import 'package:tracking_app/features/profile/domain/entities/update_vehical_request_entity.dart';
import 'package:tracking_app/features/profile/domain/usecases/get_all_vehicles_use_case.dart';
import 'package:tracking_app/features/profile/domain/usecases/get_logged_driver_data_use_case.dart';
import 'package:tracking_app/features/profile/domain/usecases/update_driver_photo_use_case.dart';
import 'package:tracking_app/features/profile/domain/usecases/update_driver_profile_use_case.dart';
import 'package:tracking_app/features/profile/domain/usecases/update_vehical_use_case.dart';

part 'states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
      this.getLoggedUserDataUseCase,
      this.updateVehicalUseCase,
      // this.changePasswordUseCase,
      this.updateDriverPhotoUseCase,
      this.updateDriverProfileUseCase,
      this.getAllVehiclesUseCase,
      ) : super(ProfileInitial());

  // handle data
  GetLoggedDriverDataUseCase getLoggedUserDataUseCase;
  GetAllVehiclesUseCase getAllVehiclesUseCase;

  UpdateDriverProfileUseCase updateDriverProfileUseCase;

  // ChangePasswordUseCase changePasswordUseCase;
  UpdateDriverPhotoUseCase updateDriverPhotoUseCase;
  UpdateVehicalUseCase updateVehicalUseCase;

  // edit profile data
  TextEditingController firstNameController =
  TextEditingController();
  TextEditingController lastNameController =
  TextEditingController();
  TextEditingController emailController =
  TextEditingController();
  TextEditingController phoneController =
  TextEditingController();
  TextEditingController vehicleTypeController =
  TextEditingController();
  TextEditingController vehicleNumberController =
  TextEditingController();
  TextEditingController vehicleLicenseController =
  TextEditingController();

  File? vehicleLicense;
  File? selectedImageFile;
  String photo = '';
  final ImagePicker _picker = ImagePicker();

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

  // Initialize cubit with user data when coming from arguments
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

  List<String> vehicles = [];

  // Initialize vehicle data
  void initializeVehicle(ProfileDriverEntity? driver) {
    if (driver != null) {
      vehicleTypeController.text =
          driver.vehicleType ?? '';
      vehicleNumberController.text =
          driver.vehicleNumber ?? '';
      vehicleLicenseController.text =
          driver.vehicleLicense ?? '';
    }
  }

  String getFileName(String filePath) {
    return filePath.split('/').last;
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

  Future<void> loadVehicles() async {
    try {
      emit(GetVehiclesLoading());
      final result = await getAllVehiclesUseCase.call();

      final vehicles =
          result.vehicles
              ?.where((e) {
            final type = e.type ?? '';
            final isObjectId =
                type.length == 24 &&
                    RegExp(
                      r'^[a-fA-F0-9]+$',
                    ).hasMatch(type);
            return !isObjectId;
          })
              .map((e) => e.type ?? '')
              .toList() ??
              [];

      emit(GetVehiclesSuccess(vehicles: vehicles));
    } catch (e) {
      emit(GetVehiclesError(message: e.toString()));
    }
  }

  Future<void> changeUserPhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        // Read the selected image bytes
        final Uint8List imageBytes = await pickedFile
            .readAsBytes();

        // Decode the image
        img.Image? originalImage = img.decodeImage(
          imageBytes,
        );

        if (originalImage != null) {
          // Convert to PNG format
          final Uint8List pngBytes = Uint8List.fromList(
            img.encodePng(originalImage),
          );

          // Create a temporary PNG file
          final Directory tempDir = Directory.systemTemp;
          final String fileName = 'default-profile.png';
          final File pngFile = File(
            '${tempDir.path}/$fileName',
          );

          // Write PNG bytes to file
          await pngFile.writeAsBytes(pngBytes);

          // Store both the file and path for different uses
          selectedImageFile = pngFile;

          emit(PhotoChangedLoadingState());

          final result = await updateDriverPhotoUseCase
              .invoke(pngFile);

          switch (result) {
            case ApiSuccessResult<
                UpdatePhotoResponseEntity
            >():
              emit(PhotoChangedSuccess());
              break;

            case ApiErrorResult<
                UpdatePhotoResponseEntity
            >():
              emit(
                PhotoChangedError(
                  message: result.errorMessage,
                ),
              );
              break;
          }
        } else {
          emit(
            PhotoChangedError(
              message: 'Failed to decode image',
            ),
          );
        }
      }
    } catch (e) {
      emit(
        PhotoChangedError(
          message:
          'Failed to pick image: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> updateVehicleInfo() async {
    emit(UpdateUserProfileLoading());

    try {
      final result = await updateVehicalUseCase.invoke(
        UpdateVehicalRequestEntity(
          vehicleType: vehicleTypeController.text
              .hexToString(),
          vehicleNumber: vehicleNumberController.text
              .trim(),
          vehicleLicense: vehicleLicense,
        ),
      );

      switch (result) {
        case ApiSuccessResult<
            UpdateProfileResponseEntity
        >():
          emit(
            UpdateUserProfileSuccess(
              updateProfileResponseEntity: result.data,
            ),
          );
          break;
        case ApiErrorResult<
            UpdateProfileResponseEntity
        >():
          emit(
            UpdateUserProfileError(
              message: result.errorMessage,
            ),
          );
          break;
      }
    } catch (e) {
      emit(
        UpdateUserProfileError(
          message:
          'Failed to update vehicle info: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> updateUserProfile() async {
    emit(UpdateUserProfileLoading());
    try {
      // Create updated user entity with current form data
      final result = await updateDriverProfileUseCase
          .invoke(
        UpdateProfileRequestEntity(
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phone: phoneController.text.trim(),
        ),
      );

      switch (result) {
        case ApiSuccessResult<
            UpdateProfileResponseEntity
        >():
          emit(
            UpdateUserProfileSuccess(
              updateProfileResponseEntity: result.data,
            ),
          );
          break;

        case ApiErrorResult<
            UpdateProfileResponseEntity
        >():
          emit(
            UpdateUserProfileError(
              message: result.errorMessage,
            ),
          );
          break;
      }
    } catch (e) {
      emit(
        UpdateUserProfileError(
          message:
          'Failed to update profile: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> getLoggedUserData() async {
    emit(GetLoggedDriverDataLoading());
    final result = await getLoggedUserDataUseCase.call();
    switch (result) {
      case ApiSuccessResult<ProfileDriverEntity>():
        emit(
          GetLoggedDriverDataSuccess(driver: result.data),
        );
        firstNameController.text =
            result.data.firstName ?? '';
        lastNameController.text =
            result.data.lastName ?? '';
        emailController.text = result.data.email ?? '';
        phoneController.text = result.data.phone ?? '';
        photo = result.data.photo ?? '';
        break;

      case ApiErrorResult<ProfileDriverEntity>():
        emit(
          GetLoggedDriverDataError(
            message: result.errorMessage,
          ),
        );
        break;
    }
  }
}
