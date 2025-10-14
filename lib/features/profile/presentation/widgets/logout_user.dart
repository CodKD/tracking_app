import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/keys/shared_key.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/route/app_routes.dart';

Future<void> logoutUser(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.confirmLogout),
      content: Text(context.l10n.areYouSureYouWantToLogOut),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.l10n.logout),
        ),
      ],
    ),
  );
  final getIt = GetIt.instance;

  if (shouldLogout ?? false) {
    await getIt<SharedPrefHelper>().removePreference(
      key: SharedPrefKeys.tokenKey,
    );

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.onBoardingView,
      (route) => false,
    );
  }
}
