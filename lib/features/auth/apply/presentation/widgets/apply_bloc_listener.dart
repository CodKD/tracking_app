import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';

class ApplyBlocListener extends StatelessWidget {
  const ApplyBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverApplyCubit, DriverApplyState>(
      listenWhen: (previous, current) =>
          current is DriverApplyLoading ||
          current is DriverApplySuccess ||
          current is DriverApplyError,
      listener: (context, state) {
        switch (state) {
          case DriverApplyLoading():
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
            break;

          case DriverApplySuccess():
            Navigator.of(context, rootNavigator: true).pop(); // close loading
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign up successfully ✅')),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.homeScreen,
              (route) => false,
            );
            break;

          case DriverApplyError():
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            break;

          default:
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
