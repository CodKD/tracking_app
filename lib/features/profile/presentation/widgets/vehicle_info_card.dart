import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/route/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/apply/domain/entities/apply_entity.dart';
import '../../domain/entities/vehicle.dart';

class VehicleInfoCard extends StatelessWidget {
  final DriverEntity driverEntity;
  final VehicleEntity vehicleEntity;
  const VehicleInfoCard({
    super.key,
    required this.driverEntity,
    required this.vehicleEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 108,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vehicleEntity.type ?? AppLocalizations.of(context).vehicleType,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 8),
                    Text(
                      vehicleEntity.type ?? AppLocalizations.of(context).vehicleType,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                    SizedBox(height: 8),
                    Text(
                      driverEntity.vehicleNumber ?? AppLocalizations.of(context).vehicleNumber,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  context.pushReplacementNamed(AppRoutes.editVehicleInfo, extra: driverEntity);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}