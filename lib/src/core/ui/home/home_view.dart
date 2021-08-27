import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_view.dart';
import 'package:mono_management/src/core/ui/expenses/expenses_view.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/core/ui/user_info/user_info_view.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(controller.getCurrentTitle()),
              ),
              body: IndexedStack(
                index: controller.tabIndex,
                children: [UserInfoView(), CurrencyRatesView(), ExpensesView()],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.tabIndex,
                onTap: (index) => controller.tabIndex = index,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle), label: 'user info'.tr),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.compare_arrows),
                    label: 'currency rates'.tr,
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: 'expenses'.tr),
                ],
              ),
            ));
  }
}
