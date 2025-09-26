import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';
import 'package:tracking_app/features/auth/apply/presentation/widgets/apply_form.dart';
import 'package:tracking_app/features/auth/apply/presentation/widgets/slect_gender.dart';

import '../../../../../core/theme/app_styles.dart' show AppStyles;

class ApplyBody extends StatelessWidget {
  const ApplyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.welcome, style: AppStyles.bold24black),
            Text(
              context.l10n.descriptionApplyPage,
              style: AppStyles.regular16gray,
            ),
            20.heightBox,
            BlocBuilder<DriverApplyCubit, DriverApplyState>(
              builder: (context, state) {
                if (state is DriverApplyCountryListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ApplyFields(cubit: context.read<DriverApplyCubit>());
                }
              },
            ),
            20.heightBox,
            ChoseGender(cubit: context.read<DriverApplyCubit>()),
            CustomButton(
              size: Size(context.width, 48),
              borderRadius: 100,
              onPressed: () {
                context.read<DriverApplyCubit>().apply();
              },
              child: Text(context.l10n.apply),
              // Text(context.l10n.apply),
            ),
          ],
        ),
      ),
    );
  }
}
