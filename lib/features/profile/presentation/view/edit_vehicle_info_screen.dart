import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';

import '../../../../core/di/di.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../auth/apply/domain/entities/apply_entity.dart';
import '../view_model/edit_vehicle_view_modle/edit_vehicle_event.dart';
import '../view_model/edit_vehicle_view_modle/edit_vehicle_view_model.dart';
import '../widgets/edit_vehicle_info_view_body.dart';

class EditVehicleInfoScreen extends StatelessWidget {
  const EditVehicleInfoScreen({super.key, required this.driverEntity});
  final DriverEntity driverEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(WidgetsKeys.kEditVehicleScreenAppBar),
        title: Text(
          AppLocalizations.of(context).editProfile,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              key: Key(WidgetsKeys.kEditVehicleScreenNotificationIcon),
              Icons.notifications_none_rounded,
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          key: const Key(WidgetsKeys.kEditVehicleInfoScreenArrowBaskIcon),
          child: IconButton(
            onPressed: () => context.canPop() ? context.pop() : null,
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<EditVehicleViewModel>()
          ..doIntent(
            EditVehicleInitializeAllDataEvent(
              vehicleId: driverEntity.vehicleType ?? "",
            ),
          ),
        child: SafeArea(child: EditVehicleInfoBody(driverEntity: driverEntity)),
      ),
    );
  }
}