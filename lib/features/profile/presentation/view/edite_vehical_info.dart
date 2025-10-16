import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/components/app_text_form_feild.dart';

class EditeVehicalInfo extends StatelessWidget {
  const EditeVehicalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.edit_vehical_info),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 24.0,
        ),
        child: Column(
          children: [
            DropdownButtonFormField(
              items: ["Car", "Truck", "Bike"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: context.l10n.vehicle_type,
                labelStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14.sp,
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {},
              validator: (v) => (v == null || v.isEmpty)
                  ? context.l10n.descriptionCountry
                  : null,
            ),
            SizedBox(height: 16.h),
            AppTextFormField(
              hintText: context.l10n.enter_vehicle_number,

              labelText: context.l10n.vehicle_number,
              validator: (v) => (v == null || v.isEmpty)
                  ? context.l10n.vehicleNumber
                  : null,
              isPassword: false,
            ),
          ],
        ),
      ),
    );
  }
}
