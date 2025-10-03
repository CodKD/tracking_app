import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tracking_app/features/profile/domain/entities/vehicle.dart';
import 'package:tracking_app/features/profile/domain/usecases/GetVehicleInfoUseCase.dart';
import 'package:tracking_app/features/profile/domain/usecases/UpdateVehicleInfoUseCase.dart';

part 'edit_vehical_state.dart';

@injectable
class EditVehicalCubit extends Cubit<VehicalState> {
  EditVehicalCubit(
    this.updateVehicleInfoUseCase,
    this.getVehicleInfoUseCase,
  ) : super(ProfileInitial());

  // handle data
  GetVehicleInfoUseCase getVehicleInfoUseCase;
  UpdateVehicleInfoUseCase updateVehicleInfoUseCase;

  // edit profile data
  TextEditingController vehicalNameController = TextEditingController();
  TextEditingController vehicalNumberController = TextEditingController();

  File? selectedImageFile;
  String photo = '';
  final ImagePicker _picker = ImagePicker();

  // Initialize cubit with user data when coming from arguments
  void initializeWithUser(VehicleEntity? driver) {
    if (driver != null) {
      vehicalNameController.text = driver.type ?? '';
      vehicalNumberController.text = driver.id ?? '';
      photo = driver.image ?? '';
      emit(GetLoggedDriverDataSuccess(driver: driver));
    }
  }

  // Change user photo using image picker and convert to PNG
  // Future<void> changeUserPhoto() async {
  //   try {
  //     final XFile? pickedFile = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 1080,
  //       maxHeight: 1080,
  //       imageQuality: 85,
  //     );
  //
  //     if (pickedFile != null) {
  //       // Read the selected image bytes
  //       final Uint8List imageBytes = await pickedFile.readAsBytes();
  //
  //       // Decode the image
  //       img.Image? originalImage = img.decodeImage(imageBytes);
  //
  //       if (originalImage != null) {
  //         // Convert to PNG format
  //         final Uint8List pngBytes = Uint8List.fromList(
  //           img.encodePng(originalImage),
  //         );
  //
  //         // Create a temporary PNG file
  //         final Directory tempDir = Directory.systemTemp;
  //         final String fileName = 'default-profile.png';
  //         final File pngFile = File('${tempDir.path}/$fileName');
  //
  //         // Write PNG bytes to file
  //         await pngFile.writeAsBytes(pngBytes);
  //
  //         // Store both the file and path for different uses
  //         selectedImageFile = pngFile;
  //
  //         emit(PhotoChangedLoadingState());
  //
  //         final result = await UpdateVehicleInfoUseCase(
  //           updateVehicleInfoUseCase.vehicleRepository,
  //         ).call();
  //
  //

  // Update user profile data
  // Future<void> updateUserProfile() async {
  //   emit(UpdateUserProfileLoading());
  //   try {
  //     // Create updated user entity with current form data
  //     final result = await updateVehicleInfoUseCase.call();
  //
  //     switch (result) {
  //       case ApiSuccessResult<VehicleEntity>():
  //         emit(
  //           UpdateUserProfileSuccess(updateProfileResponseEntity: result.data),
  //         );
  //         break;
  //
  //       case ApiErrorResult<UpdateProfileResponseEntity>():
  //         emit(UpdateUserProfileError(message: result.errorMessage));
  //         break;
  //     }
  //   } catch (e) {
  //     emit(
  //       UpdateUserProfileError(
  //         message: 'Failed to update profile: ${e.toString()}',
  //       ),
  //     );
  //   }
  // }

  Future<void> getLoggedUserData() async {
    emit(GetLoggedDriverDataLoading());
    final result = await getVehicleInfoUseCase.call();
  }
}
