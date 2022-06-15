import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/notes/statement_notes_controller.dart';
import 'package:mono_management/src/data/model/note.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class StatementNotesView extends GetView<StatementNotesController> {
  const StatementNotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatementNotesController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      (controller.statement.amount / 100).round().toString(),
                      style: TextStyle(
                        color: controller.statement.amount > 0
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Icon(
                      Icons.double_arrow,
                      color: Colors.grey[200],
                    ),
                    Text(
                      (controller.statement.balance / 100).round().toString(),
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
                        controller.statement.description,
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      controller.statement.getDateInFormat(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                child: Icon(Icons.add),
                onTap: () => Get.toNamed(Routes.noteFormRoute,
                    arguments: {'statement': controller.statement}),
              ),
            ],
          ),
          backgroundColor: appBarColor,
        ),
        drawer: NavigationDrawer(
          userInfo: controller.userInfo,
        ),
        body: _buildNoteList(),
      ),
    );
  }

  Widget _buildNoteList() {
    //Sticky category list of notes, statement is a category
    return StickyGroupedListView<Note, DateTime>(
      elements: controller.statement.notes,
      groupBy: (Note element) {
        final DateTime originalDateTime = element.createdAt!;
        return DateTime(originalDateTime.year, originalDateTime.month,
            originalDateTime.day);
      },
      floatingHeader: true,
      groupSeparatorBuilder: (Note element) => SizedBox(
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
                element.createdAtInFormat,
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8),
                      //   child: Text(
                      //     element.createdAtInFormat,
                      //     style: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
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
}
