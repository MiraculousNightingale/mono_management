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

class ExpensesController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _userInfo =  DataManager.userInfo;
    _statements =  DataManager.statements;
    _mccFilters = getMccFilter(_statements);
    // progress = false;
  }

  //List<CurrencyRate> _filteredCurrencyRates = <CurrencyRate>[];
  UserInfo _userInfo = UserInfo();
  List<Statement> _statements = <Statement>[];
  int _tabIndex = 0;
  String _accountDropDownValue = 'NaN';
  bool _showMccFilter = false;
  List<MccFilter> _mccFilters = [];
  int _selectedAccountId = 0;

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

  Future<List<Statement>> getStatements() async {
    const jsonString =
        '[{"id":"Lqoqiy-0vqMBmoLq","time":1630057840,"description":"Від: Mama","mcc":4829,"originalMcc":4829,"amount":23000,"operationAmount":23000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":256091,"hold":true},{"id":"QOyHsIFLBRBQRNv5","time":1630057834,"description":"Київстар +380673843294","mcc":4814,"originalMcc":4814,"amount":-10500,"operationAmount":-10500,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":233091,"hold":true,"receiptId":"X3M2-8868-4C0H-P03T"},{"id":"IVgjaga7MBqUfANd","time":1630057833,"description":"Київстар +380975773535","mcc":4814,"originalMcc":4814,"amount":-12500,"operationAmount":-12500,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":243591,"hold":true,"receiptId":"55XE-2M06-7043-9379"},{"id":"geQf20RqS46Ljzn0","time":1629968844,"description":"EasyPay","mcc":4816,"originalMcc":4816,"amount":-23200,"operationAmount":-23200,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":256091,"hold":false,"receiptId":"10B0-M0K1-CMCH-TTTK"},{"id":"SKwnd8mTBm0Ywvhy","time":1629903429,"description":"ГРОШ","mcc":5499,"originalMcc":5499,"amount":-37244,"operationAmount":-37244,"currencyCode":980,"commissionRate":0,"cashbackAmount":744,"balance":279291,"hold":false,"receiptId":"4976-0555-5E02-0485"},{"id":"JLBl2BZE4gyM45HR","time":1629868270,"description":"Київстар +380970606449","mcc":4814,"originalMcc":4814,"amount":-23000,"operationAmount":-23000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":316535,"hold":true,"receiptId":"TE3T-651P-2BC9-B757"},{"id":"dcYGLoxSydumm9_OIo8qGk3fSg","time":1629760293,"description":"Скасування. Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":5000,"operationAmount":5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":339535,"hold":false},{"id":"UnrUi0yaZ87aQ3Bh457ZD_A","time":1629760293,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-2676,"operationAmount":-2676,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":334535,"hold":true},{"id":"v2W0GWJ-QBY6uw7S","time":1629703565,"description":"LIQPAY*Shtrafy UA","mcc":9222,"originalMcc":9222,"amount":-57464,"operationAmount":-57464,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":337211,"hold":false,"receiptId":"AT6H-ABB6-P2T3-7XTH"},{"id":"XfsqaIMvv-vicNh7","time":1629699224,"description":"Від: Марина К.","comment":"это лишнее","mcc":4829,"originalMcc":4829,"amount":20000,"operationAmount":20000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":394675,"hold":true},{"id":"HCmp2uSqqUA-uRAm","time":1629673819,"description":"OKKO","mcc":5541,"originalMcc":5541,"amount":-104764,"operationAmount":-104764,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":374675,"hold":false,"receiptId":"6XHK-5081-TE57-4K4A"},{"id":"aFIA-eOZE1YWOqjo","time":1629669958,"description":"Марина Козубай","mcc":4829,"originalMcc":4829,"amount":-20000,"operationAmount":-20000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":479439,"hold":true,"receiptId":"3B15-H8MT-019P-XXH6"},{"id":"nHpRCYRcYEwGDcCy","time":1629539861,"description":"431414****4005","mcc":4829,"originalMcc":4829,"amount":-5500,"operationAmount":-5500,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":499439,"hold":true,"receiptId":"43E0-7579-TX5H-2ECB"},{"id":"HDwi4qv3-7E7LR8U","time":1629538241,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-5000,"operationAmount":-5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":504939,"hold":false},{"id":"z3qXtBkRiuYxXeX0","time":1629535370,"description":"Термінал IBOX","mcc":4829,"originalMcc":4829,"amount":300000,"operationAmount":300000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":509939,"hold":true},{"id":"RL49jcO1wOHNBB75","time":1629454570,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-7878,"operationAmount":-7878,"currencyCode":980,"commissionRate":0,"cashbackAmount":157,"balance":209939,"hold":false,"receiptId":"E627-TEKH-E4TE-T31X"},{"id":"ioESJhmxt4MsmQXt","time":1629396808,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":217817,"hold":false,"receiptId":"EATE-TXA2-325M-2308"},{"id":"doyPvrCTTgZEZnFm","time":1629368471,"description":"Від: Дмитро К.","mcc":4829,"originalMcc":4829,"amount":3700,"operationAmount":3700,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":218617,"hold":true},{"id":"5QWKe6_IIKh6A3Qd","time":1629368327,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-7399,"operationAmount":-7399,"currencyCode":980,"commissionRate":0,"cashbackAmount":147,"balance":214917,"hold":false,"receiptId":"7T82-BX74-MC06-9PPB"},{"id":"pJ6IIPdBKw4lOvqP","time":1629311686,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":222316,"hold":false,"receiptId":"MX1X-00X3-4PKT-2E66"},{"id":"yVwwK-vAmFCNuNSq","time":1629290264,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":223116,"hold":false,"receiptId":"PT9C-C265-KKB5-3765"},{"id":"-_UjsWtp1wRtUdi2","time":1629285688,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-6758,"operationAmount":-6758,"currencyCode":980,"commissionRate":0,"cashbackAmount":135,"balance":223916,"hold":false,"receiptId":"40T0-10TM-CPX7-PC5A"},{"id":"5LVTmAteqD_DPtst","time":1629232166,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":230674,"hold":false,"receiptId":"XT76-3XK0-T633-EKB6"},{"id":"If4qTM3i8Trbo4hM","time":1629208160,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":231474,"hold":false,"receiptId":"8XTM-03K0-KMH9-449T"},{"id":"fnDR_F59lh46MGkm","time":1629204829,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":232274,"hold":false,"receiptId":"XC9T-E7MT-AATP-2ETX"},{"id":"dkWYFPw57SVmu-sv","time":1629204404,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":233074,"hold":false,"receiptId":"9EHB-BAE8-T1M6-KX83"},{"id":"PpJy3Orh9uRXMreT","time":1629113971,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-7000,"operationAmount":-7000,"currencyCode":980,"commissionRate":0,"cashbackAmount":140,"balance":233874,"hold":false,"receiptId":"3A01-K85K-E8X4-7H9H"},{"id":"gBxj4YqhbYRcmiSs","time":1629099331,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":240874,"hold":false,"receiptId":"X252-AB1H-7M38-2337"},{"id":"7xfK98BQzi-RfvDL","time":1629098693,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":241674,"hold":false,"receiptId":"2K0M-K5EA-TK0T-H00X"},{"id":"Hb1Hso89qm29d2Po","time":1628950633,"description":"ГРОШ","mcc":5499,"originalMcc":5499,"amount":-45404,"operationAmount":-45404,"currencyCode":980,"commissionRate":0,"cashbackAmount":908,"balance":242474,"hold":false,"receiptId":"EKHC-EHM4-CM6K-M64M"},{"id":"avDy86sbT7u9EkFo","time":1628883477,"description":"Олена П.","mcc":4829,"originalMcc":4829,"amount":-2000,"operationAmount":-2000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":287878,"hold":true,"receiptId":"7K27-0549-M57E-X5A9"},{"id":"betxYswvqHuTslOV","time":1628883317,"description":"Сергій Д.","mcc":4829,"originalMcc":4829,"amount":-6000,"operationAmount":-6000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":289878,"hold":true,"receiptId":"955P-2B81-PMH9-90HA"},{"id":"byUnR5UoyyVTkBKh","time":1628855353,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-6981,"operationAmount":-6981,"currencyCode":980,"commissionRate":0,"cashbackAmount":139,"balance":295878,"hold":false,"receiptId":"H88H-5CTP-5BC9-EBAB"},{"id":"-ecoGXmhQKKEbgmH","time":1628800834,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":302859,"hold":false,"receiptId":"T2P4-2P2P-6PXP-E478"},{"id":"1Yr8lE1CYREzsg36","time":1628768299,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-5634,"operationAmount":-5634,"currencyCode":980,"commissionRate":0,"cashbackAmount":112,"balance":303659,"hold":false,"receiptId":"X471-M8PX-MA02-XBCM"},{"id":"EK2RUuBh-Oc5xqOx","time":1628701813,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-6521,"operationAmount":-6521,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":309293,"hold":false,"receiptId":"T82B-70T4-K8X1-XC2M"},{"id":"JazDlPB1SZBTeUmN","time":1628701810,"description":"Скасування. Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":5000,"operationAmount":5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":315814,"hold":false},{"id":"u5pbEnFSk6oF-YkA","time":1628700029,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-5000,"operationAmount":-5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":310814,"hold":false},{"id":"g0Imv8hfzi0IA3fs","time":1628687614,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":315814,"hold":false,"receiptId":"1T58-8X6E-MXP8-T901"},{"id":"ydLewj-P32XCTi4g","time":1628682072,"description":"Дмитро К.","mcc":4829,"originalMcc":4829,"amount":-1200,"operationAmount":-1200,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":316614,"hold":true,"receiptId":"2XX8-10A2-333P-M73C"},{"id":"8ofj47xXPnBJlVVC","time":1628681084,"description":"Від: Дмитро К.","mcc":4829,"originalMcc":4829,"amount":5200,"operationAmount":5200,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":317814,"hold":true},{"id":"kPNeALWQXvy6sppG","time":1628681058,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-10388,"operationAmount":-10388,"currencyCode":980,"commissionRate":0,"cashbackAmount":207,"balance":312614,"hold":false,"receiptId":"461P-6B8C-KAK4-1BTH"},{"id":"tAuFB5XfLd4jBC0x","time":1628615098,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":323002,"hold":false,"receiptId":"HT3E-T2HC-4397-5927"},{"id":"hMN5R49AwyfDXpHB","time":1628600705,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-8054,"operationAmount":-8054,"currencyCode":980,"commissionRate":0,"cashbackAmount":161,"balance":323802,"hold":false,"receiptId":"887H-0X8B-1B93-5H44"},{"id":"CAmS8a9g2Uf-RQ7r","time":1628531255,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":331856,"hold":false,"receiptId":"P46A-B394-AAX6-0BTH"},{"id":"YkIRKdnNPfkUWEa-","time":1628513227,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":332656,"hold":false,"receiptId":"7244-MAP3-6309-26EE"},{"id":"OPxn8TjJIXQmnau1","time":1628511798,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-3500,"operationAmount":-3500,"currencyCode":980,"commissionRate":0,"cashbackAmount":70,"balance":333456,"hold":false,"receiptId":"CP26-3301-1E87-14KE"},{"id":"ElIsEoLcGvlM2vfk","time":1628511583,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-2389,"operationAmount":-2389,"currencyCode":980,"commissionRate":0,"cashbackAmount":47,"balance":336956,"hold":false,"receiptId":"ECA1-33X8-K5M6-5216"},{"id":"LMgCb2lSn7C-APV5","time":1628437774,"description":"ГРОШ","mcc":5499,"originalMcc":5499,"amount":-27401,"operationAmount":-27401,"currencyCode":980,"commissionRate":0,"cashbackAmount":548,"balance":339345,"hold":false,"receiptId":"BXHM-M4KK-7A13-ETAK"}]';
    // var response = await _dio.get("/personal/statement/C9lcOBku2a_7pjnxfiL7Bg/1629209287/1630073287");
    // print(response.data);
    final List<dynamic> response = jsonDecode(jsonString);
    final List<Statement> statements = <Statement>[];
    for (final element in response) {
      statements.add(Statement(
          id: element["id"] ?? '',
          time: element["time"] ?? 0,
          description: element["description"] ?? '',
          comment: element["comment"] ?? '',
          mcc: element["mcc"] ?? 0,
          originalMcc: element["originalMcc"] ?? 0,
          amount: element["amount"] ?? 0,
          operationAmount: element["operationAmount"] ?? 0,
          currencyCode: element["currencyCode"] ?? 0,
          commissionRate: element["commissionRate"] ?? 0,
          cashbackAmount: element["cashbackAmount"] ?? 0,
          balance: element["balance"] ?? 0,
          hold: element["hold"] ?? false,
          receiptId: element["receiptId"] ?? '',
          counterEdrpou: element["counterEdrpou"] ?? '',
          counterIban: element["counterIban"] ?? ''));
    }
    // statements.sort((a,b)=> b.time.compareTo(a.time));
    return statements;
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

  final TextEditingController currencyNameFilter = TextEditingController();

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
}
