import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_colors.dart';

class ChoseGenderProfile extends StatelessWidget {
  const ChoseGenderProfile({required this.selectedGender, super.key});

  final String selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.l10n.gender,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        20.widthBox,
        Flexible(
          flex: 2,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              context.l10n.female,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: 'female',
            activeColor: AppColors.pink,
            //onChanged: (String? value) {},
          ),
        ),
        Flexible(
          flex: 2,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              context.l10n.male,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: 'male',
            activeColor: AppColors.pink,
            //onChanged: (String? value) {},
          ),
        ),
      ],
    );
  }
}
