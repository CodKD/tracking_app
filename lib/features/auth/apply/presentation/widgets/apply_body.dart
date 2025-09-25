import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';
import 'package:tracking_app/features/auth/apply/presentation/widgets/apply_bloc_listener.dart';
import 'package:tracking_app/features/auth/apply/presentation/widgets/custom_text_field.dart';
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
            Text(
              "Welcome!!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "You want to be a delivery man?\nJoin our team ",
              style: AppStyles.medium16black.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            ApplyFields(),
            SizedBox(height: 20),
            ChoseGender(),
            BlocBuilder<DriverApplyCubit, DriverApplyState>(
              builder: (context, state) {
                return CustomButton(
                  size: Size(context.width, 48),
                  borderRadius: 100,
                  onPressed: () {
                    validateThenDoApply(context);
                  },

                  child: state is DriverApplyLoading
                      ? CircularProgressIndicator(color: AppColors.white)
                      : Text('Apply'),
                  // Text(context.l10n.apply),
                );
              },
            ),

            ApplyBlocListener(),
          ],
        ),
      ),
    );
  }

  void validateThenDoApply(BuildContext context) {
    if (context
        .read<DriverApplyCubit>()
        .applyFormKey
        .currentState!
        .validate()) {
      context.read<DriverApplyCubit>().apply();
    }
  }
}
