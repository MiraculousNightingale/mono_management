import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/constansts.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/network/dio_manager.dart';

void main() {
  DioManager.configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1, devicePixelRatio: window.devicePixelRatio),
          child: child ?? const Offstage(),
        );
      },
      transitionDuration: AppPages.transitionDuration,
      debugShowCheckedModeBanner: false,
      translations: Localization(),
      locale: const Locale('ua', 'UA'),
      fallbackLocale: const Locale('en', 'US'),
      title: applicationTitle,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        //     // This is the theme of your application.
        //     //
        //     // Try running your application with "flutter run". You'll see the
        //     // application has a blue toolbar. Then, without quitting the app, try
        //     // changing the primarySwatch below to Colors.green and then invoke
        //     // "hot reload" (press "r" in the console where you ran "flutter run",
        //     // or simply save your changes to "hot reload" in a Flutter IDE).
        //     // Notice that the counter didn't reset back to zero; the application
        //     // is not restarted.
        primaryColor: Colors.black,
      ),
    );
  }
}
