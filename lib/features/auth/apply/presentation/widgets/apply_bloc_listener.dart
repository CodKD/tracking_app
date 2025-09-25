import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
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
        if (state case DriverApplyLoading()) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state case DriverApplySuccess()) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content: "Success",
            posActions: "OK",
            posFunction: (p0) {
              Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
            },
          );
        } else if (state case DriverApplyError()) {
          Navigator.of(context, rootNavigator: true).pop(); // close loading
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Error"),
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else {}
      },
      child: const SizedBox.shrink(),
    );
  }
}
