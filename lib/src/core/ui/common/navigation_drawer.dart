import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/app_pages.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer header'),
          ),
          //TODO: add secondary color in params
          _buildDrawerTile(
            text: 'user_info'.tr,
            icon: Icons.account_circle,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              print('user_info');
              //Get.toNamed(Routes.HOME);
            },
          ),
          _buildDrawerTile(
            text: 'currency_rates'.tr,
            icon: Icons.compare_arrows,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              print('currency_rates');
              //Get.toNamed(Routes.CURRENCY_RATES);
            },
          ),
          _buildDrawerTile(
            text: 'statements'.tr,
            icon: Icons.account_balance_wallet,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              print('statements');
              //Get.toNamed(Routes.CURRENCY_RATES);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
    bool pressed = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: pressed ? Colors.white : textIconColor),
      title: Text(
        text,
        style: TextStyle(color: pressed ? Colors.white : textIconColor),
      ),
      tileColor: pressed ? Colors.blue : tileColor,
      onTap: onTap,
    );
  }
}
