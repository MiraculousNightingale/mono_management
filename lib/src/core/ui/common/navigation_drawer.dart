import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({required this.userInfo,  Key? key}) : super(key: key);
  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(userInfo),
          //TODO: add secondary color in params
          _buildDrawerTile(
            text: Localization.keyMainPage.tr,
            icon: Icons.house_rounded,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.HOME);
            },
            pressed: Get.currentRoute == Routes.HOME,
          ),
          _buildDrawerTile(
            text: Localization.keyLineChart.tr,
            icon: Icons.show_chart,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.LINE_CHART);
            },
            pressed: Get.currentRoute == Routes.LINE_CHART,
          ),
          _buildDrawerTile(
            text: Localization.keyPieChart.tr,
            icon: Icons.pie_chart,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.PIE_CHART);
            },
            pressed: Get.currentRoute == Routes.PIE_CHART,
          ),
          _buildDrawerTile(
            text: Localization.keyBarChart.tr,
            icon: Icons.bar_chart,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.BAR_CHART);
            },
            pressed: Get.currentRoute == Routes.BAR_CHART,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(UserInfo userInfo) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      accountName: Text(userInfo.name),
      accountEmail: const Text('bohdanprus@gmail.com'),
      currentAccountPicture: const CircleAvatar(
        child: Text('БП'),
        // backgroundColor: Colors.blue,
      ),
      currentAccountPictureSize: Size.square(72),
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
