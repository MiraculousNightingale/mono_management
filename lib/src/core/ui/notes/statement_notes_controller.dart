import 'package:get/get.dart';
import 'package:mono_management/src/core/data/firestore_repository.dart';
import 'package:mono_management/src/data/model/note.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class StatementNotesController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    _userInfo = FirestoreRepository.userInfo;
    _statement = Get.arguments['statement'];
    // progress = false;
  }

  UserInfo _userInfo = UserInfo();
  Statement _statement = Statement();


  List<Note> get notes => _statement.notes;

  Statement get statement => _statement;

  UserInfo get userInfo => _userInfo;
}