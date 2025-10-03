part of 'edit_vehicle_view_model.dart';

import 'package:equatable/equatable.dart';

import '../../../../auth/apply/domain/entities/apply_entity.dart';
import '../../../domain/entities/vehicle.dart';

class EditVehicleViewModelState extends Equatable {
  final dynamic allVehicleList;
  final dynamic updateData;
  const EditVehicleViewModelState({
    this.allVehicleList,
    this.vehicleLicenseImagePath,
    this.updateData,
  });
  final BaseState<List<VehicleEntity>>? allVehicleList;
  final BaseState<DriverEntity>? updateData;
  final String? vehicleLicenseImagePath;
  EditVehicleViewModelState copyWith({
    BaseState<List<VehicleEntity>>? allVehicleList,
    BaseState<DriverEntity>? updateData,
    String? vehicleLicenseImagePath,
  }) {
    return EditVehicleViewModelState(
      allVehicleList: allVehicleList ?? this.allVehicleList,
      updateData: updateData ?? this.updateData,
      vehicleLicenseImagePath:
      vehicleLicenseImagePath ?? this.vehicleLicenseImagePath,
    );
  }

  @override
  List<Object?> get props => [
    allVehicleList,
    vehicleLicenseImagePath,
    updateData,
  ];
}