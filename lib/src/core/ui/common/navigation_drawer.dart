import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/data/repositories/flutterfire/firebase_auth_repository.dart';
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
            text: Localization.mainPage.tr,
            icon: Icons.house_rounded,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.homeRoute);
            },
            pressed: Get.currentRoute == Routes.homeRoute,
          ),
          _buildDrawerTile(
            text: Localization.lineChart.tr,
            icon: Icons.show_chart,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.lineChartRoute);
            },
            pressed: Get.currentRoute == Routes.lineChartRoute,
          ),
          _buildDrawerTile(
            text: Localization.pieChart.tr,
            icon: Icons.pie_chart,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.pieChartRoute);
            },
            pressed: Get.currentRoute == Routes.pieChartRoute,
          ),
          _buildDrawerTile(
            text: Localization.barChart.tr,
            icon: Icons.bar_chart,
            textIconColor: Colors.black,
            tileColor: Colors.white,
            onTap: () {
              Get.toNamed(Routes.barChartRote);
            },
            pressed: Get.currentRoute == Routes.barChartRote,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(UserInfo userInfo) {
    return Stack(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          accountName: Text(userInfo.name),
          accountEmail: const Text('bohdanprus@gmail.com'),
          currentAccountPicture: const CircleAvatar(
            child: Text('БП'),
            // backgroundColor: Colors.blue,
          ),
        ),
        Positioned(
          right: 5,
          top: 20,
          child: IconButton(
            onPressed: Get.find<FirebaseAuthRepository>().signOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),
      ],
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
