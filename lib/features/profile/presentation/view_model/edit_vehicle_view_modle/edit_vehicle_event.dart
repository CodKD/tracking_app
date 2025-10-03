sealed class EditVehicleEvent {}

class EditVehicleInitializeAllDataEvent extends EditVehicleEvent {
  final String vehicleId;

  EditVehicleInitializeAllDataEvent({required this.vehicleId});
}

class EditVehiclePickImageEvent extends EditVehicleEvent {}

class EditVehiclePickUpdateDataEvent extends EditVehicleEvent {}