import 'package:intl/intl.dart';
import 'package:mono_management/src/data/model/statement.dart';

class Note {
  Note({
    required this.statement,
    this.title = '',
    this.text = '',
    this.createdAt,
    this.updatedAt,
  });

  String title;
  String text;
  DateTime? createdAt;
  DateTime? updatedAt;
  Statement statement;

  String get firstTextLine => text; //TODO: implement later
  String get createdAtInFormat => DateFormat.yMd().format(createdAt!);
  String get updatedAtInFormat => DateFormat.yMd().format(updatedAt!);

}
