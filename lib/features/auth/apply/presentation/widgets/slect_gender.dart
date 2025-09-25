import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';

class ChoseGender extends StatelessWidget {
  const ChoseGender({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DriverApplyCubit>();
    return Row(
      children: [
        Text(
          'Gender',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 20),
        Flexible(
          flex: 2,
          child: RadioListTile(

            contentPadding: EdgeInsets.zero,
            title: Text(
              'Female',
              maxLines: 1,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            value: "female",

            // ignore: deprecated_member_use
            groupValue: cubit.selectedGender,
                        // ignore: deprecated_member_use
            onChanged: (value) {
              cubit.selectGender(value!);
            },
            activeColor: AppColors.pink,
          ),
        ),
        Flexible(
          flex: 2,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              'Male',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            value: "male",
            // ignore: deprecated_member_use
            groupValue: cubit.selectedGender,
            // ignore: deprecated_member_use
            onChanged: (value) {
              cubit.selectGender(value!);
            },
            activeColor: AppColors.pink,
          ),
        ),
      ],
    );
  }
}
