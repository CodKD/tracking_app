import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart';

class RefreshHome extends StatelessWidget {
  const RefreshHome({super.key, required this.viewModel});

  final HomeTabCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            context.l10n.no_orders,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          const Spacer(),
          GestureDetector(
            onTap: () {
              viewModel.getHomeData();
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
