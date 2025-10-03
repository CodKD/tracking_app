import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../auth/apply/domain/entities/apply_entity.dart';
import '../view_model/edit_vehicle_view_modle/edit_vehicle_view_model.dart';
import 'edit_vehicle_info_body_builder.dart';

class EditVehicleInfoBody extends StatefulWidget {
  const EditVehicleInfoBody({super.key, required this.driverEntity});
  final DriverEntity driverEntity;

  @override
  State<EditVehicleInfoBody> createState() => _EditVehicleInfoBodyState();
}

class _EditVehicleInfoBodyState extends State<EditVehicleInfoBody> {
  @override
  void initState() {
    final cubit = BlocProvider.of<EditVehicleViewModel>(context);
    cubit.controllerVehicleNumber.text = widget.driverEntity.vehicleNumber ?? "";
    cubit.controllerVehicleLicense.text = widget.driverEntity.vehicleLicense?.toString() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocListener<EditVehicleViewModel, EditVehicleViewModelState>(
      listener: (context, state) {
        if (state.updateData?.isLoading == true) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CupertinoActivityIndicator()),
          );
        } else if (state.updateData?.data != null) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text(local.successUpdatedData ?? 'Data updated successfully'),
              actions: [
                CupertinoDialogAction(
                  child: Text(local.ok ?? 'OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        } else if (state.updateData?.errorMessage != null) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text(state.updateData?.errorMessage ?? ""),
              actions: [
                CupertinoDialogAction(
                  child: Text(local.ok ?? 'OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      },
      child: const EditVehicleInfoViewBuilder(),
    );
  }
}