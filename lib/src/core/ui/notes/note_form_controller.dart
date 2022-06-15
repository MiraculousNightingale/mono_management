import 'package:get/get.dart';
import 'package:mono_management/src/core/data/firestore_repository.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class NoteFormController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    _userInfo = FirestoreRepository.userInfo;
    _statement = Get.arguments['statement'];
    // progress = false;
  }

  UserInfo _userInfo = UserInfo();
  Statement _statement = Statement();

  UserInfo get userInfo => _userInfo;

  Statement get statement => _statement;



}