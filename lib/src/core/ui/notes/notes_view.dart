import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/notes/notes_controller.dart';
import 'package:mono_management/src/data/model/note.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/util/currencies.dart';
import 'package:mono_management/src/util/mcc.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class NotesView extends GetView<NotesController> {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  controller.showNoteList
                      ? Localization.notes.tr
                      : Localization.statements.tr,
                ),
              ),
              controller.showNoteList
                  ? InkWell(
                      child: Icon(Icons.playlist_add_sharp),
                      onTap: () {
                        controller.showNoteList = false;
                      },
                    )
                  : InkWell(
                      child: Icon(Icons.view_list_sharp),
                      onTap: () {
                        controller.showNoteList = true;
                      },
                    ),
            ],
          ),
          backgroundColor: appBarColor,
        ),
        drawer: NavigationDrawer(
          userInfo: controller.userInfo,
        ),
        body: controller.progress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.showNoteList
                ? _buildNoteList()
                : _buildStarredStatementsList(),
      ),
    );
  }

  Widget _buildNoteList() {
    //Sticky category list of notes, statement is a category
    return StickyGroupedListView<Note, int>(
      elements: controller.notes,
      groupBy: (Note element) => element.statement.time,
      floatingHeader: true,
      groupSeparatorBuilder: (Note element) => InkWell(
        onTap: () => Get.toNamed(Routes.statementNotesRoute,
            arguments: {'statement': element.statement}),
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          height: 40,
          child: Row(
            children: [
              Text(
                (element.statement.amount / 100).round().toString(),
                style: TextStyle(
                  color: element.statement.amount > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Icon(
                Icons.double_arrow,
                color: Colors.grey[200],
              ),
              Text(
                (element.statement.balance / 100).round().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey[200],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                element.statement.description,
                style: TextStyle(
                  color: Colors.grey[200],
                ),
              )),
              Text(
                element.statement.getDateInFormat(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
      itemBuilder: (BuildContext context, Note element) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17), color: Colors.black12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            element.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          element.createdAtInFormat,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(element.text),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      itemComparator: (Note elementA, Note elementB) =>
          elementA.createdAt!.compareTo(elementB.createdAt!),
      order: StickyGroupedListOrder.DESC,
    );
  }

  Widget _buildStarredStatementsList() {
    final List<Statement> statements = controller.starredStatements;
    //List of statements with buttons to show each of it's notes
    return StickyGroupedListView<Statement, DateTime>(
      elements: statements,
      groupBy: (Statement element) {
        final DateTime originalDateTime = element.getDateInDateTime();
        return DateTime(originalDateTime.year, originalDateTime.month,
            originalDateTime.day);
      },
      floatingHeader: true,
      groupSeparatorBuilder: (Statement element) => SizedBox(
        height: 40,
        child: Center(
          child: Container(
            margin: EdgeInsets.zero,
            //padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.all(const Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                element.getDateInFormat(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (BuildContext context, Statement element) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17), color: Colors.black12),
        child: Column(
          children: [
            ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: Currency.abbreviationFromCode(
                                                element.currencyCode),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: Mcc.getDescFromCode(
                                                element.mcc),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: const Icon(Icons.list_alt),
                                      onTap: () {
                                        Get.toNamed(Routes.statementNotesRoute,
                                            arguments: {'statement': element});
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    element.isStarred
                                        ? InkWell(
                                            child:
                                                const Icon(Icons.star_outlined),
                                            onTap: () =>
                                                controller.setStarredStatement(
                                                    element.id, false),
                                          )
                                        : InkWell(
                                            child:
                                                const Icon(Icons.star_border),
                                            onTap: () =>
                                                controller.setStarredStatement(
                                                    element.id, true),
                                          ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      child: const Icon(Icons.delete_outline),
                                      onTap: () {
                                        print('cock');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 18),
                            children: [
                              TextSpan(
                                  text: element.description,
                                  style: const TextStyle()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 18),
                                  children: [
                                    TextSpan(
                                      text: (element.amount / 100).toString(),
                                      style: TextStyle(
                                        color: element.amount > 0
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          // flex: 2,
                          child: Icon(Icons.double_arrow_rounded),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                      text: (element.balance / 100).toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      itemComparator: (Statement elementA, Statement elementB) =>
          elementA.time.compareTo(elementB.time),
      order: StickyGroupedListOrder.DESC,
    );
  }
}
