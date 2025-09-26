import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
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
          current is DriverApplyCountryListLoading ||
          current is DriverApplyCountryList ||
          current is DriverApplyError,
      listener: (context, state) {
        if (state case DriverApplyLoading()) {
          DialogUtils.showLoading(
            context: context,
            loadingMessage: context.l10n.loading,
          );
        } else if (state case DriverApplyCountryListLoading()) {
          DialogUtils.showLoading(
            context: context,
            loadingMessage: context.l10n.loading,
          );
        } else if (state case DriverApplyCountryList()) {
          // DialogUtils.hideLoading(context);
        } else if (state case DriverApplySuccess()) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content: "Success",
            posActions: "OK",
            posFunction: (p0) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
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
