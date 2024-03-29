import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_view.dart';
import 'package:mono_management/src/core/ui/expenses/expenses_view.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/core/ui/user_info/user_info_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.getCurrentTitle(),
          ),
          backgroundColor: Colors.black,
        ),
        drawer: NavigationDrawer(
          userInfo: controller.userInfo,
        ),
        body: Text('c@ck'),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) => {Get.offNamed(Routes.bottomNavBarRoutes[index])},
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
        ),
      ),
    );
  }
}
