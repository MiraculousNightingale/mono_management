import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';

class BotNavBar extends StatelessWidget{
  const BotNavBar({Key? key, this.currentIndex}) : super(key: key);

  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex ?? 0,
      onTap: (index) => {Get.toNamed(Routes.bottomNavBarRoutes[index])},
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: Localization.userInfo.tr),
        BottomNavigationBarItem(
          icon: const Icon(Icons.compare_arrows),
          label: Localization.currencyRates.tr,
        ),
        BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet),
            label: Localization.statements.tr),
      ],
    );
  }

}