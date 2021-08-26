import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

import '../../app_pages.dart';

class CurrencyRatesView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('currency rates'.tr),);
  }
}
