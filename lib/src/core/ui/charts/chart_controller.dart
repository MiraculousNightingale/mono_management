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

class ChartController extends GetxController {

  @override
  Future<void> onInit() async {
    super.onInit();
    //TODO: Remove async data load
    _userInfo = await DataManager.getUserInfo();
    _currencyRates = await DataManager.getCurrencyRates();
    _statements = await DataManager.getStatements();
    progress = false;
  }

  UserInfo _userInfo = UserInfo();
  List<CurrencyRate> _currencyRates = <CurrencyRate>[];
  List<Statement> _statements = <Statement>[];

  bool _progress = true;

  set progress(bool value) {
    _progress = value;
    update();
  }

  bool get progress => _progress;

  UserInfo get userInfo => _userInfo;

  List<CurrencyRate> get currencyRates => _currencyRates;

  List<Statement> get statements => _statements;

  List<PieChartStatement> get pieChartStatementData {
    final Map<int, int> result = {};
    for (final statement in statements) {
      if (statement.amount < 0) {
        if (result.containsKey(statement.mcc)) {
          result.update(statement.mcc,
                  (value) => result[statement.mcc]! + statement.amount);
        } else {
          result.addAll({statement.mcc: statement.amount});
        }
      }
    }
    final List<PieChartStatement> sortedResult =
    result.entries.map((e) => PieChartStatement.fromMapEntry(e)).toList();
    sortedResult.sort((a, b) => b.amount.compareTo(a.amount));
    return sortedResult;
  }

}
