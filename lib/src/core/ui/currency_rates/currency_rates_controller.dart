/// Placeholder for a future controller if it has to be implemented
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/data/firestore_repository.dart';
import 'package:mono_management/src/data/model/currency_filter.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

class CurrencyRatesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _userInfo = FirestoreRepository.userInfo;
    _currencyRates = FirestoreRepository.currencyRates;
    _currencyFilters = getCurrencyFilter(_currencyRates);
    // progress = false;
  }

  UserInfo _userInfo = UserInfo();
  List<CurrencyRate> _currencyRates = <CurrencyRate>[];

  TextEditingController filterCurrencyNameController = TextEditingController();
  //List<CurrencyRate> _filteredCurrencyRates = <CurrencyRate>[];
  final List<Statement> _statements = <Statement>[];
  int _tabIndex = 0;
  String _accountDropDownValue = 'NaN';
  bool _showCurrencyFilter = false;
  final bool _showMccFilter = false;
  List<CurrencyFilter> _currencyFilters = [];
  List<MccFilter> _mccFilters = [];
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

  List<CurrencyFilter> getCurrencyFilter(List<CurrencyRate> currencyRates) {
    final uniqueCurrencyCodes = <dynamic>{};
    final List<CurrencyRate> uniqueCurrenciesByCodeA = <CurrencyRate>[];
    uniqueCurrenciesByCodeA.addAll(currencyRates);
    uniqueCurrenciesByCodeA.retainWhere(
        (element) => uniqueCurrencyCodes.add(element.currencyCodeA));
    final List<CurrencyFilter> filters = [];
    for (final CurrencyRate currency in uniqueCurrenciesByCodeA) {
      filters.add(CurrencyFilter(currency.currencyCodeA, true));
    }
    return filters;
  }

  List<CurrencyRate> getFilteredCurrencyRates() {
    // List<CurrencyRate> filteredCurrencyRates = <CurrencyRate>[];
    // for(CurrencyFilter currencyFilter in _currencyFilters){
    //   if(currencyFilter.show){
    //     filteredCurrencyRates.add(currencyFilter.currencyRate);
    //   }
    // }
    // filteredCurrencyRates = _currencyFilters.where((e) => e.show).map((e) => e.currencyRate).toList();
    return _currencyRates
        .where((currencyRate) => _currencyFilters.any((filter) =>
            filter.currencyCode == currencyRate.currencyCodeA && filter.show))
        .toList();
  }

  List<Statement> getFilteredStatements() {
    return _statements
        .where((statement) => _mccFilters
            .any((filter) => filter.mcc == statement.mcc && filter.show))
        .toList();
  }

  bool _progress = false;

  set progress(bool value) {
    _progress = value;
    update();
  }

  bool get progress => _progress;

  UserInfo get userInfo => _userInfo;

  List<CurrencyRate> get currencyRates => _currencyRates;

  List<Statement> get statements => _statements;

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

  String get accountDropDownValue => _accountDropDownValue;

  set accountDropDownValue(String value) {
    _accountDropDownValue = value;
    update();
  }

  bool get showCurrencyFilter => _showCurrencyFilter;

  set showCurrencyFilter(bool value) {
    _showCurrencyFilter = value;
    update();
  }

  List<CurrencyFilter> get currencyFilters {
    return _currencyFilters
        .where((element) =>
            Currency.abbreviationFromCode(element.currencyCode)
                .toLowerCase()
                .contains(currencyFilterSearch.toLowerCase()) ||
            Currency.nameFromCode(element.currencyCode)
                .toLowerCase()
                .contains(currencyFilterSearch.toLowerCase()))
        .toList();
  }

  set currencyFilters(List<CurrencyFilter> value) {
    _currencyFilters = value;
    update();
  }

  void setCurrencyFiltersVisibility(bool value) {
    for (final CurrencyFilter currencyFilter in currencyFilters) {
      currencyFilter.show = value;
    }
    update();
  }

  String _currencyFilterSearch = '';

  String get currencyFilterSearch => _currencyFilterSearch;

  set currencyFilterSearch(String value) {
    _currencyFilterSearch = value;
    print(_currencyFilterSearch);
    update();
  }
}
