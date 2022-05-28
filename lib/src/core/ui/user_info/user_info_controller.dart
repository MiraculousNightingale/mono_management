import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/data/data_manager.dart';
import 'package:mono_management/src/data/model/currency_filter.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/data/model/pie_chart_statement.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

class UserInfoController extends GetxController {

  @override
  void onInit()  {
    super.onInit();
    _userInfo =  DataManager.userInfo;
    _statements =  DataManager.statements;
    // progress = false;
  }

  UserInfo _userInfo = UserInfo();
  List<Statement> _statements = <Statement>[];

  int _tabIndex = 0;
  int _selectedAccountId = 0;

  void setSelectedAccount(int id) {
    selectedAccountId = id;
  }

  String getCurrentTitle() {
    final titles = {
      0: 'user info'.tr,
      1: 'currency rates'.tr,
      2: 'expenses'.tr,
    };
    return titles[_tabIndex] ?? 'NaN';
  }

  bool _progress = false;

  set progress(bool value) {
    _progress = value;
    update();
  }

  bool get progress => _progress;

  UserInfo get userInfo => _userInfo;

  int get tabIndex => _tabIndex;

  int get selectedAccountId => _selectedAccountId;

  set selectedAccountId(int value) {
    _selectedAccountId = value;
    update();
  }

  set tabIndex(int value) {
    _tabIndex = value;
    update();
  }

  int get last7DaysChange {
    return _statements
        .where((element) => element.time > _statements.last.time - 604800000)
        .fold(0, (previousValue, element) => previousValue + element.amount);
  }

}
