import 'dart:convert';

import 'package:get/get.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class HomeController extends GetxController {
  UserInfo _userInfo = UserInfo();
  int _tabIndex = 0;

  Future<UserInfo> getUserInfo() async {
    await Future.delayed(Duration(seconds: 2));
    //var response = await DioManager().get("personal/client-info");
    var jsonString =
        '{"clientId":"5VrvgtAumT","name":"Прус Богдан","webHookUrl":"","permissions":"psf","accounts":[{"id":"C9lcOBku2a_7pjnxfiL7Bg","sendId":"5VrvgtAumT","currencyCode":980,"cashbackType":"UAH","balance":339535,"creditLimit":0,"maskedPan":["537541******2242"],"type":"black","iban":"UA603220010000026202303328022"}]}';
    Map<String, dynamic> response = jsonDecode(jsonString);
    return UserInfo.fromJson(response);
  }

  @override
  void onInit() async {
    super.onInit();
    _userInfo = await getUserInfo();
    progress=false;
  }

  bool _progress = true;
  set progress(bool value) {
    _progress = value;
    update();
  }
  bool get progress => _progress;

  UserInfo get userInfo => _userInfo;

  int get tabIndex => _tabIndex;

  set tabIndex(int value) {
    _tabIndex = value;
    update();
  }
}
