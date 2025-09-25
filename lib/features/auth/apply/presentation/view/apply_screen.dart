import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/features/auth/apply/presentation/cubit/driver_apply_cubit.dart';
import 'package:tracking_app/features/auth/apply/presentation/widgets/apply_body.dart';

class ApplyScreen extends StatelessWidget {
  const ApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<DriverApplyCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(Icons.arrow_back_ios),
          ),
          leadingWidth: 20,
          title: Text(context.l10n.apply),
        ),
        body: SafeArea(child: ApplyBody()),
      ),
    );
  }
}
