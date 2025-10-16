import 'package:flutter/material.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/views/home_tab.dart';
import 'package:tracking_app/features/orders/presentation/pages/orders_view.dart';
import 'package:tracking_app/features/profile/presentation/view/view.dart';

class HomeViewModel extends ChangeNotifier {
  // hold data
  int currentIndex = 0;
  List<Widget> pages = [const HomeTab(), const OrdersView(), const ProfileTab()];

  // handle logic
  void setCurrentIndex(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
