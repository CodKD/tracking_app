import 'package:flutter/material.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/views/home_tab.dart';
import 'package:tracking_app/features/home/presentation/Tabs/order_tab/order_tab.dart';
import 'package:tracking_app/features/home/presentation/Tabs/profile_tab/profile_tab.dart';

class HomeViewModel extends ChangeNotifier {
  // hold data
  int currentIndex = 0;
  List<Widget> pages = [const HomeTab(), const OrderTab(), const ProfileTab()];

  // handle logic
  void setCurrentIndex(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      notifyListeners();
    }
  }
}
