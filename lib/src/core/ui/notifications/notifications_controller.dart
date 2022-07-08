import 'package:get/get.dart';
import 'package:mono_management/src/core/data/firestore_repository.dart';
import 'package:mono_management/src/data/model/note.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class NotificationsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _userInfo = FirestoreRepository.userInfo;
    // progress = false;
  }

  UserInfo _userInfo = UserInfo();
  // final List<Statement> _starredStatements = <Statement>[];
  // final List<Note> _notes = <Note>[];
  bool _progress = false; //true by default
  bool _showNoteList = true;

  List<Note> get notes {
    final List<Note> result = <Note>[];
    for (final Statement statement in starredStatements) {
      result.addAll(statement.notes);
    }
    return result;
  }

  UserInfo get userInfo => _userInfo;

  set progress(bool value) {
    _progress = value;
    update();
  }

  bool get progress => _progress;

  List<Statement> get starredStatements => FirestoreRepository.statements
      .where((element) => element.isStarred)
      .toList();

  bool get showNoteList => _showNoteList;

  set showNoteList(bool value) {
    _showNoteList = value;
    update();
  }

  void setStarredStatement(String statementId, bool isStarred) {
    FirestoreRepository.setStarredStatement(statementId, isStarred)
        .then((value) {
      starredStatements
          .where((element) => element.id == statementId)
          .first
          .isStarred = isStarred;
      update();
    });
  }
}
