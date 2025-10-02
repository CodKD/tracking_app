import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/spacer_media_quiey.dart';
import 'package:tracking_app/features/profile/presentation/view_model/cubit.dart';
import 'package:tracking_app/features/profile/presentation/widgets/app_bar_profile.dart';
import 'package:tracking_app/features/profile/presentation/widgets/profile_body.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getLoggedDriverData(),
      child: SafeArea(
        child: Column(
          children: [
            const AppBarProfile(),
            SizedBox(height: 3.heightPercent(context)),
            const ProfileBody(),
          ],
        ),
      ),
    );
  }
}
