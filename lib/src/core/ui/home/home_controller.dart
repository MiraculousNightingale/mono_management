import 'dart:convert';

import 'package:get/get.dart';
import 'package:mono_management/src/data/model/currency_filter.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

class HomeController extends GetxController {
  UserInfo _userInfo = UserInfo();
  List<CurrencyRate> _currencyRates = <CurrencyRate>[];

  //List<CurrencyRate> _filteredCurrencyRates = <CurrencyRate>[];
  List<Statement> _statements = <Statement>[];
  int _tabIndex = 0;
  String _accountDropDownValue = 'NaN';
  bool _showCurrencyFilter = false;
  bool _showMccFilter = false;
  bool _showExpenseCharts = false;
  List<CurrencyFilter> _currencyFilters = [];
  List<MccFilter> _mccFilters = [];
  int _selectedAccountId = 0;

  bool get showExpenseCharts => _showExpenseCharts;

  set showExpenseCharts(bool value) {
    _showExpenseCharts = value;
    update();
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

  Future<UserInfo> getUserInfo() async {
    // await Future.delayed(Duration(seconds: 2));
    //var response = await DioManager().get("personal/client-info");
    var jsonString =
        '{"clientId":"5VrvgtAumT","name":"Прус Богдан","webHookUrl":"","permissions":"psf","accounts":[{"id":"C9lcOBku2a_7pjnxfiL7Bg","sendId":"5VrvgtAumT","currencyCode":980,"cashbackType":"UAH","balance":339535,"creditLimit":0,"maskedPan":["537541******2242"],"type":"black","iban":"UA603220010000026202303328022"},{"id":"890nxfiL7Bg_7pjnxfiL7Bg","sendId":"5VrvgtAumT","currencyCode":980,"cashbackType":"UAH","balance":339535,"creditLimit":0,"maskedPan":["228541******3222"],"type":"black","iban":"UA603220010000026202303328022"},{"id":"FdbCECoOku2a_ChUixkLo7Bg","sendId":"5VrvgtAumT","currencyCode":980,"cashbackType":"UAH","balance":339535,"creditLimit":0,"maskedPan":["898577******9342"],"type":"black","iban":"UA603220010000026202303328022"}]}';
    Map<String, dynamic> response = jsonDecode(jsonString);
    return UserInfo.fromJson(response);
  }

  Future<List<CurrencyRate>> getCurrencyRates() async {
    var jsonString =
        '[{"currencyCodeA":840,"currencyCodeB":980,"date":1629982806,"rateBuy":26.75,"rateSell":26.9498},{"currencyCodeA":978,"currencyCodeB":980,"date":1629971406,"rateBuy":31.35,"rateSell":31.6496},{"currencyCodeA":643,"currencyCodeB":980,"date":1629925806,"rateBuy":0.355,"rateSell":0.375},{"currencyCodeA":978,"currencyCodeB":840,"date":1629925806,"rateBuy":1.167,"rateSell":1.181},{"currencyCodeA":985,"currencyCodeB":980,"date":1630009584,"rateBuy":6.84,"rateSell":7.04,"rateCross":7.04},{"currencyCodeA":826,"currencyCodeB":980,"date":1630009605,"rateCross":37.1096},{"currencyCodeA":392,"currencyCodeB":980,"date":1630003131,"rateCross":0.246},{"currencyCodeA":756,"currencyCodeB":980,"date":1630009470,"rateCross":29.564},{"currencyCodeA":156,"currencyCodeB":980,"date":1630007640,"rateCross":4.1626},{"currencyCodeA":784,"currencyCodeB":980,"date":1630009296,"rateCross":7.3389},{"currencyCodeA":971,"currencyCodeB":980,"date":1621225573,"rateCross":0.3583},{"currencyCodeA":8,"currencyCodeB":980,"date":1630009581,"rateCross":0.2605},{"currencyCodeA":51,"currencyCodeB":980,"date":1630007982,"rateCross":0.0551},{"currencyCodeA":973,"currencyCodeB":980,"date":1629810840,"rateCross":0.0422},{"currencyCodeA":32,"currencyCodeB":980,"date":1630009191,"rateCross":0.2768},{"currencyCodeA":36,"currencyCodeB":980,"date":1630005050,"rateCross":19.6257},{"currencyCodeA":944,"currencyCodeB":980,"date":1630008424,"rateCross":15.8608},{"currencyCodeA":50,"currencyCodeB":980,"date":1629970295,"rateCross":0.3167},{"currencyCodeA":975,"currencyCodeB":980,"date":1630009615,"rateCross":16.2338},{"currencyCodeA":48,"currencyCodeB":980,"date":1629900736,"rateCross":71.3993},{"currencyCodeA":108,"currencyCodeB":980,"date":1538606522,"rateCross":0.0158},{"currencyCodeA":96,"currencyCodeB":980,"date":1628668181,"rateCross":19.8353},{"currencyCodeA":68,"currencyCodeB":980,"date":1628423499,"rateCross":3.9311},{"currencyCodeA":986,"currencyCodeB":980,"date":1630007732,"rateCross":5.1795},{"currencyCodeA":72,"currencyCodeB":980,"date":1629979688,"rateCross":2.4012},{"currencyCodeA":933,"currencyCodeB":980,"date":1630009558,"rateCross":10.7123},{"currencyCodeA":124,"currencyCodeB":980,"date":1630009507,"rateCross":21.4178},{"currencyCodeA":976,"currencyCodeB":980,"date":1629982806,"rateCross":0.0137},{"currencyCodeA":152,"currencyCodeB":980,"date":1629949675,"rateCross":0.0343},{"currencyCodeA":170,"currencyCodeB":980,"date":1630006161,"rateCross":0.0069},{"currencyCodeA":188,"currencyCodeB":980,"date":1630006186,"rateCross":0.0434},{"currencyCodeA":192,"currencyCodeB":980,"date":1629982806,"rateCross":1.1146},{"currencyCodeA":203,"currencyCodeB":980,"date":1630009582,"rateCross":1.244},{"currencyCodeA":262,"currencyCodeB":980,"date":1629654354,"rateCross":0.1511},{"currencyCodeA":208,"currencyCodeB":980,"date":1630009296,"rateCross":4.269},{"currencyCodeA":12,"currencyCodeB":980,"date":1629903438,"rateCross":0.1981},{"currencyCodeA":818,"currencyCodeB":980,"date":1630009170,"rateCross":1.7229},{"currencyCodeA":230,"currencyCodeB":980,"date":1629656456,"rateCross":0.5903},{"currencyCodeA":981,"currencyCodeB":980,"date":1630009499,"rateCross":8.7027},{"currencyCodeA":936,"currencyCodeB":980,"date":1629024420,"rateCross":4.604},{"currencyCodeA":270,"currencyCodeB":980,"date":1624650409,"rateCross":0.5744},{"currencyCodeA":324,"currencyCodeB":980,"date":1621350723,"rateCross":0.0028},{"currencyCodeA":344,"currencyCodeB":980,"date":1630009600,"rateCross":3.4626},{"currencyCodeA":191,"currencyCodeB":980,"date":1630009504,"rateCross":4.2292},{"currencyCodeA":348,"currencyCodeB":980,"date":1630009565,"rateCross":0.0913},{"currencyCodeA":360,"currencyCodeB":980,"date":1629999312,"rateCross":0.0018},{"currencyCodeA":376,"currencyCodeB":980,"date":1630008165,"rateCross":8.3824},{"currencyCodeA":356,"currencyCodeB":980,"date":1630004145,"rateCross":0.3633},{"currencyCodeA":368,"currencyCodeB":980,"date":1629884414,"rateCross":0.0183},{"currencyCodeA":364,"currencyCodeB":980,"date":1629982806,"rateCross":0.0006},{"currencyCodeA":352,"currencyCodeB":980,"date":1630009456,"rateCross":0.2127},{"currencyCodeA":400,"currencyCodeB":980,"date":1630000455,"rateCross":38.0645},{"currencyCodeA":404,"currencyCodeB":980,"date":1630003148,"rateCross":0.2457},{"currencyCodeA":417,"currencyCodeB":980,"date":1630009321,"rateCross":0.3181},{"currencyCodeA":116,"currencyCodeB":980,"date":1628797873,"rateCross":0.0065},{"currencyCodeA":408,"currencyCodeB":980,"date":1629982806,"rateCross":12.1591},{"currencyCodeA":410,"currencyCodeB":980,"date":1629993691,"rateCross":0.0231},{"currencyCodeA":414,"currencyCodeB":980,"date":1629887724,"rateCross":89.3565},{"currencyCodeA":398,"currencyCodeB":980,"date":1630004241,"rateCross":0.0634},{"currencyCodeA":418,"currencyCodeB":980,"date":1627906149,"rateCross":0.0028},{"currencyCodeA":422,"currencyCodeB":980,"date":1629813339,"rateCross":0.0022},{"currencyCodeA":144,"currencyCodeB":980,"date":1629985577,"rateCross":0.1352},{"currencyCodeA":434,"currencyCodeB":980,"date":1629982806,"rateCross":5.9222},{"currencyCodeA":504,"currencyCodeB":980,"date":1629992065,"rateCross":3.0032},{"currencyCodeA":498,"currencyCodeB":980,"date":1630008850,"rateCross":1.5265},{"currencyCodeA":969,"currencyCodeB":980,"date":1628750227,"rateCross":0.007},{"currencyCodeA":807,"currencyCodeB":980,"date":1630009314,"rateCross":0.5144},{"currencyCodeA":496,"currencyCodeB":980,"date":1603268632,"rateCross":0.0102},{"currencyCodeA":478,"currencyCodeB":980,"date":1629982806,"rateCross":0.0745},{"currencyCodeA":480,"currencyCodeB":980,"date":1628684701,"rateCross":0.6309},{"currencyCodeA":454,"currencyCodeB":980,"date":1581405226,"rateCross":0.0337},{"currencyCodeA":484,"currencyCodeB":980,"date":1630008737,"rateCross":1.3331},{"currencyCodeA":458,"currencyCodeB":980,"date":1629980127,"rateCross":6.4077},{"currencyCodeA":943,"currencyCodeB":980,"date":1629980348,"rateCross":0.4209},{"currencyCodeA":516,"currencyCodeB":980,"date":1629999508,"rateCross":1.8095},{"currencyCodeA":566,"currencyCodeB":980,"date":1630003504,"rateCross":0.0655},{"currencyCodeA":558,"currencyCodeB":980,"date":1630007932,"rateCross":0.7693},{"currencyCodeA":578,"currencyCodeB":980,"date":1630007606,"rateCross":3.069},{"currencyCodeA":524,"currencyCodeB":980,"date":1629957793,"rateCross":0.2266},{"currencyCodeA":554,"currencyCodeB":980,"date":1629966748,"rateCross":18.7437},{"currencyCodeA":512,"currencyCodeB":980,"date":1630003743,"rateCross":70.0521},{"currencyCodeA":604,"currencyCodeB":980,"date":1629999633,"rateCross":6.5896},{"currencyCodeA":608,"currencyCodeB":980,"date":1629969657,"rateCross":0.5415},{"currencyCodeA":586,"currencyCodeB":980,"date":1629995934,"rateCross":0.1626},{"currencyCodeA":600,"currencyCodeB":980,"date":1623790865,"rateCross":0.004},{"currencyCodeA":634,"currencyCodeB":980,"date":1630006637,"rateCross":7.4032},{"currencyCodeA":946,"currencyCodeB":980,"date":1630009181,"rateCross":6.4428},{"currencyCodeA":941,"currencyCodeB":980,"date":1630009579,"rateCross":0.2695},{"currencyCodeA":682,"currencyCodeB":980,"date":1630006484,"rateCross":7.188},{"currencyCodeA":690,"currencyCodeB":980,"date":1629990544,"rateCross":1.9671},{"currencyCodeA":938,"currencyCodeB":980,"date":1629982806,"rateCross":0.0606},{"currencyCodeA":752,"currencyCodeB":980,"date":1630008856,"rateCross":3.1089},{"currencyCodeA":702,"currencyCodeB":980,"date":1629985891,"rateCross":19.9293},{"currencyCodeA":694,"currencyCodeB":980,"date":1628377797,"rateCross":0.0026},{"currencyCodeA":706,"currencyCodeB":980,"date":1629982806,"rateCross":0.0465},{"currencyCodeA":968,"currencyCodeB":980,"date":1591303043,"rateCross":3.5865},{"currencyCodeA":760,"currencyCodeB":980,"date":1629982806,"rateCross":0.0106},{"currencyCodeA":748,"currencyCodeB":980,"date":1629982806,"rateCross":1.7961},{"currencyCodeA":764,"currencyCodeB":980,"date":1630001748,"rateCross":0.8254},{"currencyCodeA":972,"currencyCodeB":980,"date":1629899224,"rateCross":2.3708},{"currencyCodeA":795,"currencyCodeB":980,"date":1629982806,"rateCross":0.0015},{"currencyCodeA":788,"currencyCodeB":980,"date":1630004582,"rateCross":9.6586},{"currencyCodeA":949,"currencyCodeB":980,"date":1630009611,"rateCross":3.2198},{"currencyCodeA":901,"currencyCodeB":980,"date":1629964780,"rateCross":0.9631},{"currencyCodeA":834,"currencyCodeB":980,"date":1629979317,"rateCross":0.0117},{"currencyCodeA":800,"currencyCodeB":980,"date":1629981305,"rateCross":0.0076},{"currencyCodeA":858,"currencyCodeB":980,"date":1629926733,"rateCross":0.6277},{"currencyCodeA":860,"currencyCodeB":980,"date":1629997906,"rateCross":0.0025},{"currencyCodeA":704,"currencyCodeB":980,"date":1629997358,"rateCross":0.0011},{"currencyCodeA":950,"currencyCodeB":980,"date":1629826735,"rateCross":0.0479},{"currencyCodeA":952,"currencyCodeB":980,"date":1629983651,"rateCross":0.0483},{"currencyCodeA":886,"currencyCodeB":980,"date":1543715495,"rateCross":0.112},{"currencyCodeA":710,"currencyCodeB":980,"date":1630000345,"rateCross":1.8084},{"currencyCodeA":894,"currencyCodeB":980,"date":1629982806,"rateCross":0.0016}]';
    List<dynamic> response = jsonDecode(jsonString);
    // var response = await _dio.get("/bank/currency");
    // print(response.data);
    List<CurrencyRate> currencyRates = <CurrencyRate>[];
    for (dynamic element in response) {
      currencyRates.add(CurrencyRate(
          currencyCodeA: element["currencyCodeA"] ?? 0,
          currencyCodeB: element["currencyCodeB"] ?? 0,
          date: element["date"] ?? 0,
          rateBuy: element["rateBuy"] ?? 0.0,
          rateSell: element["rateSell"] ?? 0.0,
          rateCross: element["rateCross"] ?? 0.0));
    }
    currencyRates.retainWhere((element) =>
        Currency().abbreviationFromCode(element.currencyCodeA) != 'NaN' &&
        Currency().symbolFromCode(element.currencyCodeA) != 'NaN');
    return currencyRates;
  }

  Future<List<Statement>> getStatements() async {
    var jsonString =
        '[{"id":"Lqoqiy-0vqMBmoLq","time":1630057840,"description":"Від: Mama","mcc":4829,"originalMcc":4829,"amount":23000,"operationAmount":23000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":256091,"hold":true},{"id":"QOyHsIFLBRBQRNv5","time":1630057834,"description":"Київстар +380673843294","mcc":4814,"originalMcc":4814,"amount":-10500,"operationAmount":-10500,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":233091,"hold":true,"receiptId":"X3M2-8868-4C0H-P03T"},{"id":"IVgjaga7MBqUfANd","time":1630057833,"description":"Київстар +380975773535","mcc":4814,"originalMcc":4814,"amount":-12500,"operationAmount":-12500,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":243591,"hold":true,"receiptId":"55XE-2M06-7043-9379"},{"id":"geQf20RqS46Ljzn0","time":1629968844,"description":"EasyPay","mcc":4816,"originalMcc":4816,"amount":-23200,"operationAmount":-23200,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":256091,"hold":false,"receiptId":"10B0-M0K1-CMCH-TTTK"},{"id":"SKwnd8mTBm0Ywvhy","time":1629903429,"description":"ГРОШ","mcc":5499,"originalMcc":5499,"amount":-37244,"operationAmount":-37244,"currencyCode":980,"commissionRate":0,"cashbackAmount":744,"balance":279291,"hold":false,"receiptId":"4976-0555-5E02-0485"},{"id":"JLBl2BZE4gyM45HR","time":1629868270,"description":"Київстар +380970606449","mcc":4814,"originalMcc":4814,"amount":-23000,"operationAmount":-23000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":316535,"hold":true,"receiptId":"TE3T-651P-2BC9-B757"},{"id":"dcYGLoxSydumm9_OIo8qGk3fSg","time":1629760293,"description":"Скасування. Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":5000,"operationAmount":5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":339535,"hold":false},{"id":"UnrUi0yaZ87aQ3Bh457ZD_A","time":1629760293,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-2676,"operationAmount":-2676,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":334535,"hold":true},{"id":"v2W0GWJ-QBY6uw7S","time":1629703565,"description":"LIQPAY*Shtrafy UA","mcc":9222,"originalMcc":9222,"amount":-57464,"operationAmount":-57464,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":337211,"hold":false,"receiptId":"AT6H-ABB6-P2T3-7XTH"},{"id":"XfsqaIMvv-vicNh7","time":1629699224,"description":"Від: Марина К.","comment":"это лишнее","mcc":4829,"originalMcc":4829,"amount":20000,"operationAmount":20000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":394675,"hold":true},{"id":"HCmp2uSqqUA-uRAm","time":1629673819,"description":"OKKO","mcc":5541,"originalMcc":5541,"amount":-104764,"operationAmount":-104764,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":374675,"hold":false,"receiptId":"6XHK-5081-TE57-4K4A"},{"id":"aFIA-eOZE1YWOqjo","time":1629669958,"description":"Марина Козубай","mcc":4829,"originalMcc":4829,"amount":-20000,"operationAmount":-20000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":479439,"hold":true,"receiptId":"3B15-H8MT-019P-XXH6"},{"id":"nHpRCYRcYEwGDcCy","time":1629539861,"description":"431414****4005","mcc":4829,"originalMcc":4829,"amount":-5500,"operationAmount":-5500,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":499439,"hold":true,"receiptId":"43E0-7579-TX5H-2ECB"},{"id":"HDwi4qv3-7E7LR8U","time":1629538241,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-5000,"operationAmount":-5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":504939,"hold":false},{"id":"z3qXtBkRiuYxXeX0","time":1629535370,"description":"Термінал IBOX","mcc":4829,"originalMcc":4829,"amount":300000,"operationAmount":300000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":509939,"hold":true},{"id":"RL49jcO1wOHNBB75","time":1629454570,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-7878,"operationAmount":-7878,"currencyCode":980,"commissionRate":0,"cashbackAmount":157,"balance":209939,"hold":false,"receiptId":"E627-TEKH-E4TE-T31X"},{"id":"ioESJhmxt4MsmQXt","time":1629396808,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":217817,"hold":false,"receiptId":"EATE-TXA2-325M-2308"},{"id":"doyPvrCTTgZEZnFm","time":1629368471,"description":"Від: Дмитро К.","mcc":4829,"originalMcc":4829,"amount":3700,"operationAmount":3700,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":218617,"hold":true},{"id":"5QWKe6_IIKh6A3Qd","time":1629368327,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-7399,"operationAmount":-7399,"currencyCode":980,"commissionRate":0,"cashbackAmount":147,"balance":214917,"hold":false,"receiptId":"7T82-BX74-MC06-9PPB"},{"id":"pJ6IIPdBKw4lOvqP","time":1629311686,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":222316,"hold":false,"receiptId":"MX1X-00X3-4PKT-2E66"},{"id":"yVwwK-vAmFCNuNSq","time":1629290264,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":223116,"hold":false,"receiptId":"PT9C-C265-KKB5-3765"},{"id":"-_UjsWtp1wRtUdi2","time":1629285688,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-6758,"operationAmount":-6758,"currencyCode":980,"commissionRate":0,"cashbackAmount":135,"balance":223916,"hold":false,"receiptId":"40T0-10TM-CPX7-PC5A"},{"id":"5LVTmAteqD_DPtst","time":1629232166,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":230674,"hold":false,"receiptId":"XT76-3XK0-T633-EKB6"},{"id":"If4qTM3i8Trbo4hM","time":1629208160,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":231474,"hold":false,"receiptId":"8XTM-03K0-KMH9-449T"},{"id":"fnDR_F59lh46MGkm","time":1629204829,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":232274,"hold":false,"receiptId":"XC9T-E7MT-AATP-2ETX"},{"id":"dkWYFPw57SVmu-sv","time":1629204404,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":233074,"hold":false,"receiptId":"9EHB-BAE8-T1M6-KX83"},{"id":"PpJy3Orh9uRXMreT","time":1629113971,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-7000,"operationAmount":-7000,"currencyCode":980,"commissionRate":0,"cashbackAmount":140,"balance":233874,"hold":false,"receiptId":"3A01-K85K-E8X4-7H9H"},{"id":"gBxj4YqhbYRcmiSs","time":1629099331,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":240874,"hold":false,"receiptId":"X252-AB1H-7M38-2337"},{"id":"7xfK98BQzi-RfvDL","time":1629098693,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":241674,"hold":false,"receiptId":"2K0M-K5EA-TK0T-H00X"},{"id":"Hb1Hso89qm29d2Po","time":1628950633,"description":"ГРОШ","mcc":5499,"originalMcc":5499,"amount":-45404,"operationAmount":-45404,"currencyCode":980,"commissionRate":0,"cashbackAmount":908,"balance":242474,"hold":false,"receiptId":"EKHC-EHM4-CM6K-M64M"},{"id":"avDy86sbT7u9EkFo","time":1628883477,"description":"Олена П.","mcc":4829,"originalMcc":4829,"amount":-2000,"operationAmount":-2000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":287878,"hold":true,"receiptId":"7K27-0549-M57E-X5A9"},{"id":"betxYswvqHuTslOV","time":1628883317,"description":"Сергій Д.","mcc":4829,"originalMcc":4829,"amount":-6000,"operationAmount":-6000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":289878,"hold":true,"receiptId":"955P-2B81-PMH9-90HA"},{"id":"byUnR5UoyyVTkBKh","time":1628855353,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-6981,"operationAmount":-6981,"currencyCode":980,"commissionRate":0,"cashbackAmount":139,"balance":295878,"hold":false,"receiptId":"H88H-5CTP-5BC9-EBAB"},{"id":"-ecoGXmhQKKEbgmH","time":1628800834,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":302859,"hold":false,"receiptId":"T2P4-2P2P-6PXP-E478"},{"id":"1Yr8lE1CYREzsg36","time":1628768299,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-5634,"operationAmount":-5634,"currencyCode":980,"commissionRate":0,"cashbackAmount":112,"balance":303659,"hold":false,"receiptId":"X471-M8PX-MA02-XBCM"},{"id":"EK2RUuBh-Oc5xqOx","time":1628701813,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-6521,"operationAmount":-6521,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":309293,"hold":false,"receiptId":"T82B-70T4-K8X1-XC2M"},{"id":"JazDlPB1SZBTeUmN","time":1628701810,"description":"Скасування. Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":5000,"operationAmount":5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":315814,"hold":false},{"id":"u5pbEnFSk6oF-YkA","time":1628700029,"description":"Електросамокати Bolt","mcc":7999,"originalMcc":7999,"amount":-5000,"operationAmount":-5000,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":310814,"hold":false},{"id":"g0Imv8hfzi0IA3fs","time":1628687614,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":315814,"hold":false,"receiptId":"1T58-8X6E-MXP8-T901"},{"id":"ydLewj-P32XCTi4g","time":1628682072,"description":"Дмитро К.","mcc":4829,"originalMcc":4829,"amount":-1200,"operationAmount":-1200,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":316614,"hold":true,"receiptId":"2XX8-10A2-333P-M73C"},{"id":"8ofj47xXPnBJlVVC","time":1628681084,"description":"Від: Дмитро К.","mcc":4829,"originalMcc":4829,"amount":5200,"operationAmount":5200,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":317814,"hold":true},{"id":"kPNeALWQXvy6sppG","time":1628681058,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-10388,"operationAmount":-10388,"currencyCode":980,"commissionRate":0,"cashbackAmount":207,"balance":312614,"hold":false,"receiptId":"461P-6B8C-KAK4-1BTH"},{"id":"tAuFB5XfLd4jBC0x","time":1628615098,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":323002,"hold":false,"receiptId":"HT3E-T2HC-4397-5927"},{"id":"hMN5R49AwyfDXpHB","time":1628600705,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-8054,"operationAmount":-8054,"currencyCode":980,"commissionRate":0,"cashbackAmount":161,"balance":323802,"hold":false,"receiptId":"887H-0X8B-1B93-5H44"},{"id":"CAmS8a9g2Uf-RQ7r","time":1628531255,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":331856,"hold":false,"receiptId":"P46A-B394-AAX6-0BTH"},{"id":"YkIRKdnNPfkUWEa-","time":1628513227,"description":"Вінницякартсервіс","mcc":4111,"originalMcc":4111,"amount":-800,"operationAmount":-800,"currencyCode":980,"commissionRate":0,"cashbackAmount":0,"balance":332656,"hold":false,"receiptId":"7244-MAP3-6309-26EE"},{"id":"OPxn8TjJIXQmnau1","time":1628511798,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-3500,"operationAmount":-3500,"currencyCode":980,"commissionRate":0,"cashbackAmount":70,"balance":333456,"hold":false,"receiptId":"CP26-3301-1E87-14KE"},{"id":"ElIsEoLcGvlM2vfk","time":1628511583,"description":"Сільпо","mcc":5411,"originalMcc":5411,"amount":-2389,"operationAmount":-2389,"currencyCode":980,"commissionRate":0,"cashbackAmount":47,"balance":336956,"hold":false,"receiptId":"ECA1-33X8-K5M6-5216"},{"id":"LMgCb2lSn7C-APV5","time":1628437774,"description":"ГРОШ","mcc":5499,"originalMcc":5499,"amount":-27401,"operationAmount":-27401,"currencyCode":980,"commissionRate":0,"cashbackAmount":548,"balance":339345,"hold":false,"receiptId":"BXHM-M4KK-7A13-ETAK"}]';
    // var response = await _dio.get("/personal/statement/C9lcOBku2a_7pjnxfiL7Bg/1629209287/1630073287");
    // print(response.data);
    List<dynamic> response = jsonDecode(jsonString);
    List<Statement> statements = <Statement>[];
    for (dynamic element in response) {
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

  List<CurrencyFilter> getCurrencyFilter(List<CurrencyRate> currencyRates) {
    var uniqueCurrencyCodes = Set();
    List<CurrencyRate> uniqueCurrenciesByCodeA = <CurrencyRate>[];
    uniqueCurrenciesByCodeA.addAll(currencyRates);
    uniqueCurrenciesByCodeA.retainWhere(
        (element) => uniqueCurrencyCodes.add(element.currencyCodeA));
    List<CurrencyFilter> filters = [];
    for (CurrencyRate currency in uniqueCurrenciesByCodeA) {
      filters.add(CurrencyFilter(currency.currencyCodeA, true));
    }
    return filters;
  }

  List<MccFilter> getMccFilter(List<Statement> statements) {
    var uniqueMcc = Set();
    List<Statement> uniqueStatementsByMcc = <Statement>[];
    uniqueStatementsByMcc.addAll(statements);
    uniqueStatementsByMcc.retainWhere((element) => uniqueMcc.add(element.mcc));
    List<MccFilter> filters = [];
    for (Statement statement in uniqueStatementsByMcc) {
      filters.add(MccFilter(statement.mcc, true));
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

  @override
  void onInit() async {
    super.onInit();
    _userInfo = await getUserInfo();
    _currencyRates = await getCurrencyRates();
    _currencyFilters = getCurrencyFilter(_currencyRates);
    _statements = await getStatements();
    _mccFilters = getMccFilter(_statements);
    progress = false;
  }

  bool _progress = true;

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

  List<CurrencyFilter> get currencyFilters => _currencyFilters;

  set currencyFilters(List<CurrencyFilter> value) {
    _currencyFilters = value;
  }

  List<MccFilter> get mccFilters => _mccFilters;

  set mccFilters(List<MccFilter> value) {
    _mccFilters = value;
  }
}
