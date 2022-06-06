import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/data/firestore_repository.dart';
import 'package:mono_management/src/core/ui/notes/notes_controller.dart';
import 'package:mono_management/src/data/model/currency_filter.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/data/model/pie_chart_statement.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ExpensesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _userInfo = FirestoreRepository.userInfo;
    _statements = FirestoreRepository.statements;
    _mccFilters = getMccFilter(_statements);
    // progress = false;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    // _userInfo = await FirestoreRepository.getUserInfo();
    // _statements = await FirestoreRepository.getStatements();
    // _mccFilters = getMccFilter(_statements);
    // progress = false;
  }

  //List<CurrencyRate> _filteredCurrencyRates = <CurrencyRate>[];
  UserInfo _userInfo = UserInfo();
  List<Statement> _statements = <Statement>[];
  int _tabIndex = 0;
  String _accountDropDownValue = 'NaN';
  bool _showMccFilter = false;
  bool _showDatePickerDialog = false;
  List<MccFilter> _mccFilters = [];
  int _selectedAccountId = 0;
  String _searchStatementDesc = '';
  String _searchMccFilterName = '';
  PickerDateRange filterStatementDateRange = const PickerDateRange(null, null);
  StatementOperationType _filterStatementType = StatementOperationType.all;
  final TextEditingController filterStatementDescController =
      TextEditingController();
  final TextEditingController filterDateRangeTextController =
      TextEditingController();
  final TextEditingController filterMccFilterNameController =
      TextEditingController();
  final DateRangePickerController filterDateRangeController =
      DateRangePickerController();

  StatementOperationType get filterStatementType => _filterStatementType;

  set filterStatementType(StatementOperationType value) {
    _filterStatementType = value;
    update();
  }

  List<bool> get filterToggleButtonsSelected {
    return StatementOperationType.values
        .map((e) => e == filterStatementType)
        .toList();
  }

  bool get showDatePickerDialog => _showDatePickerDialog;

  set showDatePickerDialog(bool value) {
    _showDatePickerDialog = value;
    update();
  }

  set searchStatementDesc(String value) {
    _searchStatementDesc = value;
    update();
  }

  String get searchStatementDesc => _searchStatementDesc;

  set searchMccFilterName(String value) {
    _searchMccFilterName = value;
    update();
  }

  String get searchMccFilterName => _searchMccFilterName;

  List<MccFilter> get filteredMccFilters {
    return _mccFilters
        .where(
          (element) => element.nameLc.contains(
            _searchMccFilterName.toLowerCase(),
          ),
        )
        .toList();
  }

  List<Statement> get filteredStatements {
    final List<Statement> result = <Statement>[];
    for (final Statement statement in statements) {
      //Desc search
      bool descSearchPassed = true;
      if (searchStatementDesc.isNotEmpty) {
        descSearchPassed = statement.description.toLowerCase().contains(
              searchStatementDesc.toLowerCase(),
            );
      }
      //Date check
      bool dateCheckPassed = true;
      //TODO: if you select only 1 day so startDate=endDate it doesn't work. fix it
      if (filterStatementDateRange.startDate != null &&
          filterStatementDateRange.endDate != null) {
        dateCheckPassed = statement
                    .getDateInDateTime()
                    .compareTo(filterStatementDateRange.startDate!) >=
                0 &&
            statement
                    .getDateInDateTime()
                    .compareTo(filterStatementDateRange.endDate!) <=
                0;
      }
      //Type check
      bool typeCheckPassed = true;
      switch (_filterStatementType) {
        case StatementOperationType.deposit:
          typeCheckPassed = statement.amount > 0;
          break;
        case StatementOperationType.withdrawal:
          typeCheckPassed = statement.amount < 0;
          break;
        default:
          typeCheckPassed = true;
          break;
      }
      //Mcc check
      final bool mccCheckPassed = _mccFilters
          .firstWhere((element) => element.mcc == statement.mcc)
          .show;
      if (descSearchPassed &&
          dateCheckPassed &&
          typeCheckPassed &&
          mccCheckPassed) {
        result.add(statement);
      }
    }
    return result;
  }

  bool get showMccFilter => _showMccFilter;

  set showMccFilter(bool value) {
    _showMccFilter = value;
    update();
  }

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

  List<MccFilter> getMccFilter(List<Statement> statements) {
    final Set uniqueMcc = {};
    final List<Statement> uniqueStatementsByMcc = <Statement>[];
    uniqueStatementsByMcc.addAll(statements);
    uniqueStatementsByMcc.retainWhere((element) => uniqueMcc.add(element.mcc));
    final List<MccFilter> filters = [];
    for (final Statement statement in uniqueStatementsByMcc) {
      filters.add(MccFilter(statement.mcc, true));
    }
    return filters;
  }

  List<Statement> getFilteredStatements() {
    return _statements
        .where((statement) => _mccFilters
            .any((filter) => filter.mcc == statement.mcc && filter.show))
        .toList();
  }

  // bool _progress = true;
  bool _progress = false;

  set progress(bool value) {
    _progress = value;
    update();
  }

  bool get progress => _progress;

  UserInfo get userInfo => _userInfo;

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

  bool _showStatementFilter = false;

  bool get showStatementFilter => _showStatementFilter;

  set showStatementFilter(bool value) {
    _showStatementFilter = value;
    update();
  }

  List<MccFilter> get mccFilters => _mccFilters;

  set mccFilters(List<MccFilter> value) {
    _mccFilters = value;
    update();
  }

  void setStarredStatement(String statementId, bool isStarred) {
    FirestoreRepository.setStarredStatement(statementId, isStarred)
        .then((value) {
      _statements
          .where((element) => element.id == statementId)
          .first
          .isStarred = isStarred;
      update();
      // Get.find<NotesController>().update();
    });
  }
}
