import 'dart:convert';

import 'package:get/get.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class HomeController extends GetxController {
  UserInfo _userInfo = UserInfo();
  List<CurrencyRate> _currencyRates = <CurrencyRate>[];
  int _tabIndex = 0;

  String getCurrentTitle(){
    final titles = {
      0: 'user info'.tr,
      1: 'currency rates'.tr,
      2: 'expenses'.tr,
    };
    return titles[_tabIndex] ?? 'NoTranslation';
  }

  Future<UserInfo> getUserInfo() async {
    // await Future.delayed(Duration(seconds: 2));
    //var response = await DioManager().get("personal/client-info");
    var jsonString =
        '{"clientId":"5VrvgtAumT","name":"Прус Богдан","webHookUrl":"","permissions":"psf","accounts":[{"id":"C9lcOBku2a_7pjnxfiL7Bg","sendId":"5VrvgtAumT","currencyCode":980,"cashbackType":"UAH","balance":339535,"creditLimit":0,"maskedPan":["537541******2242"],"type":"black","iban":"UA603220010000026202303328022"}]}';
    Map<String, dynamic> response = jsonDecode(jsonString);
    return UserInfo.fromJson(response);
  }

  Future<List<CurrencyRate>> getCurrencyRates() async {
    var jsonString =
        '[{"currencyCodeA":840,"currencyCodeB":980,"date":1629982806,"rateBuy":26.75,"rateSell":26.9498},{"currencyCodeA":978,"currencyCodeB":980,"date":1629971406,"rateBuy":31.35,"rateSell":31.6496},{"currencyCodeA":643,"currencyCodeB":980,"date":1629925806,"rateBuy":0.355,"rateSell":0.375},{"currencyCodeA":978,"currencyCodeB":840,"date":1629925806,"rateBuy":1.167,"rateSell":1.181},{"currencyCodeA":985,"currencyCodeB":980,"date":1630009584,"rateBuy":6.84,"rateSell":7.04,"rateCross":7.04},{"currencyCodeA":826,"currencyCodeB":980,"date":1630009605,"rateCross":37.1096},{"currencyCodeA":392,"currencyCodeB":980,"date":1630003131,"rateCross":0.246},{"currencyCodeA":756,"currencyCodeB":980,"date":1630009470,"rateCross":29.564},{"currencyCodeA":156,"currencyCodeB":980,"date":1630007640,"rateCross":4.1626},{"currencyCodeA":784,"currencyCodeB":980,"date":1630009296,"rateCross":7.3389},{"currencyCodeA":971,"currencyCodeB":980,"date":1621225573,"rateCross":0.3583},{"currencyCodeA":8,"currencyCodeB":980,"date":1630009581,"rateCross":0.2605},{"currencyCodeA":51,"currencyCodeB":980,"date":1630007982,"rateCross":0.0551},{"currencyCodeA":973,"currencyCodeB":980,"date":1629810840,"rateCross":0.0422},{"currencyCodeA":32,"currencyCodeB":980,"date":1630009191,"rateCross":0.2768},{"currencyCodeA":36,"currencyCodeB":980,"date":1630005050,"rateCross":19.6257},{"currencyCodeA":944,"currencyCodeB":980,"date":1630008424,"rateCross":15.8608},{"currencyCodeA":50,"currencyCodeB":980,"date":1629970295,"rateCross":0.3167},{"currencyCodeA":975,"currencyCodeB":980,"date":1630009615,"rateCross":16.2338},{"currencyCodeA":48,"currencyCodeB":980,"date":1629900736,"rateCross":71.3993},{"currencyCodeA":108,"currencyCodeB":980,"date":1538606522,"rateCross":0.0158},{"currencyCodeA":96,"currencyCodeB":980,"date":1628668181,"rateCross":19.8353},{"currencyCodeA":68,"currencyCodeB":980,"date":1628423499,"rateCross":3.9311},{"currencyCodeA":986,"currencyCodeB":980,"date":1630007732,"rateCross":5.1795},{"currencyCodeA":72,"currencyCodeB":980,"date":1629979688,"rateCross":2.4012},{"currencyCodeA":933,"currencyCodeB":980,"date":1630009558,"rateCross":10.7123},{"currencyCodeA":124,"currencyCodeB":980,"date":1630009507,"rateCross":21.4178},{"currencyCodeA":976,"currencyCodeB":980,"date":1629982806,"rateCross":0.0137},{"currencyCodeA":152,"currencyCodeB":980,"date":1629949675,"rateCross":0.0343},{"currencyCodeA":170,"currencyCodeB":980,"date":1630006161,"rateCross":0.0069},{"currencyCodeA":188,"currencyCodeB":980,"date":1630006186,"rateCross":0.0434},{"currencyCodeA":192,"currencyCodeB":980,"date":1629982806,"rateCross":1.1146},{"currencyCodeA":203,"currencyCodeB":980,"date":1630009582,"rateCross":1.244},{"currencyCodeA":262,"currencyCodeB":980,"date":1629654354,"rateCross":0.1511},{"currencyCodeA":208,"currencyCodeB":980,"date":1630009296,"rateCross":4.269},{"currencyCodeA":12,"currencyCodeB":980,"date":1629903438,"rateCross":0.1981},{"currencyCodeA":818,"currencyCodeB":980,"date":1630009170,"rateCross":1.7229},{"currencyCodeA":230,"currencyCodeB":980,"date":1629656456,"rateCross":0.5903},{"currencyCodeA":981,"currencyCodeB":980,"date":1630009499,"rateCross":8.7027},{"currencyCodeA":936,"currencyCodeB":980,"date":1629024420,"rateCross":4.604},{"currencyCodeA":270,"currencyCodeB":980,"date":1624650409,"rateCross":0.5744},{"currencyCodeA":324,"currencyCodeB":980,"date":1621350723,"rateCross":0.0028},{"currencyCodeA":344,"currencyCodeB":980,"date":1630009600,"rateCross":3.4626},{"currencyCodeA":191,"currencyCodeB":980,"date":1630009504,"rateCross":4.2292},{"currencyCodeA":348,"currencyCodeB":980,"date":1630009565,"rateCross":0.0913},{"currencyCodeA":360,"currencyCodeB":980,"date":1629999312,"rateCross":0.0018},{"currencyCodeA":376,"currencyCodeB":980,"date":1630008165,"rateCross":8.3824},{"currencyCodeA":356,"currencyCodeB":980,"date":1630004145,"rateCross":0.3633},{"currencyCodeA":368,"currencyCodeB":980,"date":1629884414,"rateCross":0.0183},{"currencyCodeA":364,"currencyCodeB":980,"date":1629982806,"rateCross":0.0006},{"currencyCodeA":352,"currencyCodeB":980,"date":1630009456,"rateCross":0.2127},{"currencyCodeA":400,"currencyCodeB":980,"date":1630000455,"rateCross":38.0645},{"currencyCodeA":404,"currencyCodeB":980,"date":1630003148,"rateCross":0.2457},{"currencyCodeA":417,"currencyCodeB":980,"date":1630009321,"rateCross":0.3181},{"currencyCodeA":116,"currencyCodeB":980,"date":1628797873,"rateCross":0.0065},{"currencyCodeA":408,"currencyCodeB":980,"date":1629982806,"rateCross":12.1591},{"currencyCodeA":410,"currencyCodeB":980,"date":1629993691,"rateCross":0.0231},{"currencyCodeA":414,"currencyCodeB":980,"date":1629887724,"rateCross":89.3565},{"currencyCodeA":398,"currencyCodeB":980,"date":1630004241,"rateCross":0.0634},{"currencyCodeA":418,"currencyCodeB":980,"date":1627906149,"rateCross":0.0028},{"currencyCodeA":422,"currencyCodeB":980,"date":1629813339,"rateCross":0.0022},{"currencyCodeA":144,"currencyCodeB":980,"date":1629985577,"rateCross":0.1352},{"currencyCodeA":434,"currencyCodeB":980,"date":1629982806,"rateCross":5.9222},{"currencyCodeA":504,"currencyCodeB":980,"date":1629992065,"rateCross":3.0032},{"currencyCodeA":498,"currencyCodeB":980,"date":1630008850,"rateCross":1.5265},{"currencyCodeA":969,"currencyCodeB":980,"date":1628750227,"rateCross":0.007},{"currencyCodeA":807,"currencyCodeB":980,"date":1630009314,"rateCross":0.5144},{"currencyCodeA":496,"currencyCodeB":980,"date":1603268632,"rateCross":0.0102},{"currencyCodeA":478,"currencyCodeB":980,"date":1629982806,"rateCross":0.0745},{"currencyCodeA":480,"currencyCodeB":980,"date":1628684701,"rateCross":0.6309},{"currencyCodeA":454,"currencyCodeB":980,"date":1581405226,"rateCross":0.0337},{"currencyCodeA":484,"currencyCodeB":980,"date":1630008737,"rateCross":1.3331},{"currencyCodeA":458,"currencyCodeB":980,"date":1629980127,"rateCross":6.4077},{"currencyCodeA":943,"currencyCodeB":980,"date":1629980348,"rateCross":0.4209},{"currencyCodeA":516,"currencyCodeB":980,"date":1629999508,"rateCross":1.8095},{"currencyCodeA":566,"currencyCodeB":980,"date":1630003504,"rateCross":0.0655},{"currencyCodeA":558,"currencyCodeB":980,"date":1630007932,"rateCross":0.7693},{"currencyCodeA":578,"currencyCodeB":980,"date":1630007606,"rateCross":3.069},{"currencyCodeA":524,"currencyCodeB":980,"date":1629957793,"rateCross":0.2266},{"currencyCodeA":554,"currencyCodeB":980,"date":1629966748,"rateCross":18.7437},{"currencyCodeA":512,"currencyCodeB":980,"date":1630003743,"rateCross":70.0521},{"currencyCodeA":604,"currencyCodeB":980,"date":1629999633,"rateCross":6.5896},{"currencyCodeA":608,"currencyCodeB":980,"date":1629969657,"rateCross":0.5415},{"currencyCodeA":586,"currencyCodeB":980,"date":1629995934,"rateCross":0.1626},{"currencyCodeA":600,"currencyCodeB":980,"date":1623790865,"rateCross":0.004},{"currencyCodeA":634,"currencyCodeB":980,"date":1630006637,"rateCross":7.4032},{"currencyCodeA":946,"currencyCodeB":980,"date":1630009181,"rateCross":6.4428},{"currencyCodeA":941,"currencyCodeB":980,"date":1630009579,"rateCross":0.2695},{"currencyCodeA":682,"currencyCodeB":980,"date":1630006484,"rateCross":7.188},{"currencyCodeA":690,"currencyCodeB":980,"date":1629990544,"rateCross":1.9671},{"currencyCodeA":938,"currencyCodeB":980,"date":1629982806,"rateCross":0.0606},{"currencyCodeA":752,"currencyCodeB":980,"date":1630008856,"rateCross":3.1089},{"currencyCodeA":702,"currencyCodeB":980,"date":1629985891,"rateCross":19.9293},{"currencyCodeA":694,"currencyCodeB":980,"date":1628377797,"rateCross":0.0026},{"currencyCodeA":706,"currencyCodeB":980,"date":1629982806,"rateCross":0.0465},{"currencyCodeA":968,"currencyCodeB":980,"date":1591303043,"rateCross":3.5865},{"currencyCodeA":760,"currencyCodeB":980,"date":1629982806,"rateCross":0.0106},{"currencyCodeA":748,"currencyCodeB":980,"date":1629982806,"rateCross":1.7961},{"currencyCodeA":764,"currencyCodeB":980,"date":1630001748,"rateCross":0.8254},{"currencyCodeA":972,"currencyCodeB":980,"date":1629899224,"rateCross":2.3708},{"currencyCodeA":795,"currencyCodeB":980,"date":1629982806,"rateCross":0.0015},{"currencyCodeA":788,"currencyCodeB":980,"date":1630004582,"rateCross":9.6586},{"currencyCodeA":949,"currencyCodeB":980,"date":1630009611,"rateCross":3.2198},{"currencyCodeA":901,"currencyCodeB":980,"date":1629964780,"rateCross":0.9631},{"currencyCodeA":834,"currencyCodeB":980,"date":1629979317,"rateCross":0.0117},{"currencyCodeA":800,"currencyCodeB":980,"date":1629981305,"rateCross":0.0076},{"currencyCodeA":858,"currencyCodeB":980,"date":1629926733,"rateCross":0.6277},{"currencyCodeA":860,"currencyCodeB":980,"date":1629997906,"rateCross":0.0025},{"currencyCodeA":704,"currencyCodeB":980,"date":1629997358,"rateCross":0.0011},{"currencyCodeA":950,"currencyCodeB":980,"date":1629826735,"rateCross":0.0479},{"currencyCodeA":952,"currencyCodeB":980,"date":1629983651,"rateCross":0.0483},{"currencyCodeA":886,"currencyCodeB":980,"date":1543715495,"rateCross":0.112},{"currencyCodeA":710,"currencyCodeB":980,"date":1630000345,"rateCross":1.8084},{"currencyCodeA":894,"currencyCodeB":980,"date":1629982806,"rateCross":0.0016}]';
    List<dynamic> response = jsonDecode(jsonString);
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

    return currencyRates;
  }

  @override
  void onInit() async {
    super.onInit();
    _userInfo = await getUserInfo();
    _currencyRates = await getCurrencyRates();
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

  int get tabIndex => _tabIndex;

  set tabIndex(int value) {
    _tabIndex = value;
    update();
  }
}
