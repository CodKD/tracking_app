import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api_layer/api_result/api_result.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../../auth/apply/domain/entities/apply_entity.dart';
import '../../../domain/entities/vehicle.dart';

import 'package:path/path.dart' as p;
import 'dart:io';

import '../../../domain/usecases/GetVehicleInfoUseCase.dart';
import '../../../domain/usecases/UpdateVehicleInfoUseCase.dart';
import 'edit_vehicle_event.dart';

@injectable
class EditVehicleViewModel extends Cubit<EditVehicleViewModelState> {
  EditVehicleViewModel(this._allVehiclesUseCase, this._updateVehicleUseCase)
      : super(EditVehicleViewModelState.initial()) {
    controllerVehicleLicense.addListener(checkEnableButton);
    controllerVehicleNumber.addListener(checkEnableButton);
    controllerVehicleType.addListener(checkEnableButton);
  }

  final GetVehicleInfoUseCase _allVehiclesUseCase;
  final UpdateVehicleInfoUseCase _updateVehicleUseCase;

  Future<void> doIntent(EditVehicleEvent event) async {
    switch (event) {
      case EditVehicleInitializeAllDataEvent():
        _getAllData(event.vehicleId);
      case EditVehiclePickImageEvent():
        _getVehicleLicense();
      case EditVehiclePickUpdateDataEvent():
        _updateVehicleInfo();
    }
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isUserAuthenticated = ValueNotifier(false);
  String? vehicleLicenseImagePath;
  ValueNotifier<VehicleEntity?> selectedVehicle = ValueNotifier<VehicleEntity?>(
    null,
  );
  TextEditingController controllerVehicleType = TextEditingController();
  TextEditingController controllerVehicleNumber = TextEditingController();
  TextEditingController controllerVehicleLicense = TextEditingController();
  String? _initialVehicleType;
  String? _initialVehicleNumber;
  String? _initialVehicleLicense;
  bool _isSettingInitial = false;

  void _initialValue() {
    _initialVehicleType = controllerVehicleType.text;
    _initialVehicleNumber = controllerVehicleNumber.text;
    _initialVehicleLicense = controllerVehicleLicense.text;
  }

  Future<void> _getAllData(String vehicleId) async {
    _isSettingInitial = true;
    await _getAllVehicles();
    _getSelectedVehicle(vehicleId);
    _initialValue();
    _isSettingInitial = false;
  }

  Future<void> _getAllVehicles() async {
    emit(state.copyWith(allVehicleList: BaseState<List<VehicleEntity>>.loading()));
    final result = await _allVehiclesUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<VehicleEntity>>():
        emit(state.copyWith(allVehicleList: BaseState<List<VehicleEntity>>.success(result.data)));
      case ApiErrorResult<List<VehicleEntity>>():
        emit(
          state.copyWith(allVehicleList: BaseState<List<VehicleEntity>>.error(result.errorMessage)),
        );
    }
  }

  Future<void> _getVehicleLicense() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(vehicleLicenseImagePath: pickedFile.path));
      vehicleLicenseImagePath = pickedFile.path;
      controllerVehicleLicense.text = p.basename(pickedFile.path);
    }
  }

  void _getSelectedVehicle(String vehicleId) {
    final vehicle = state.allVehicleList?.data?.firstWhereOrNull(
          (v) => v.id == vehicleId,
    );
    selectedVehicle.value = vehicle;
    controllerVehicleType.text =
        vehicle?.type ?? AppLocalizations.of(globalKey.currentContext!)?.pleaseSelectVehicleType ?? '';
  }

  Future<void> _updateVehicleInfo() async {
    emit(state.copyWith(updateData: BaseState<DriverEntity>.loading()));
    final file = vehicleLicenseImagePath != null
        ? File(vehicleLicenseImagePath!)
        : null;
    final result = await _updateVehicleUseCase.call(
      UpdateVehicleRequestEntity(
        vehicleType: selectedVehicle.value?.id,
        vehicleNumber: controllerVehicleNumber.text,
        vehicleLicense: file,
      ),
    );
    switch (result) {
      case ApiSuccessResult<DriverEntity>():
        emit(state.copyWith(updateData: BaseState<DriverEntity>.success(result.data)));
      case ApiErrorResult<DriverEntity>():
        emit(state.copyWith(updateData: BaseState<DriverEntity>.error(result.errorMessage)));
    }
  }

  void checkEnableButton() {
    if (_isSettingInitial) return;
    isUserAuthenticated.value =
        _initialVehicleNumber != controllerVehicleNumber.text ||
            _initialVehicleType != controllerVehicleType.text ||
            _initialVehicleLicense != controllerVehicleLicense.text;
  }
}