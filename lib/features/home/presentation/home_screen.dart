import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/features/home/presentation/blocs/home_view_model.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          // indexed stack for save tab state across navigation
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: IndexedStack(
                index: viewModel.currentIndex,
                children: viewModel.pages,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.setCurrentIndex,
            elevation: 0,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Assets.icon.homeIcon.path)),
                label: locale.home,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Assets.icon.orderIcon.path)),
                label: locale.orders,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(Assets.icon.profileIcon.path)),
                label: locale.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
