import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

class ExpensesView extends GetView<HomeController> {
  List<DropdownMenuItem<String>> _getAccountDropDownItems() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    items.add(DropdownMenuItem<String>(
      child: Text('select account'.tr),
      value: 'NaN',
    ));
    for (Account account in controller.userInfo.accounts) {
      items.add(DropdownMenuItem<String>(
        child: Text('${account.maskedPan}'),
        value: account.id,
      ));
    }
    return items;
  }

  Widget _buildStatementList(List<Statement> statements) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.black12),
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
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18),
                                                  children: [
                                                TextSpan(
                                                    text:
                                                        '${Currency().abbreviationFromCode(statements[index].currencyCode)}',
                                                    style: TextStyle(
                                                        // fontWeight:
                                                        // FontWeight.bold
                                                        )),
                                              ])),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18),
                                                  children: [
                                                TextSpan(
                                                    text: DateFormat.yMd()
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                statements[index]
                                                                        .time *
                                                                    1000)),
                                                    style: TextStyle(
                                                        // fontWeight:
                                                        //     FontWeight.bold
                                                        )),
                                              ])),
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
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 18),
                                      children: [
                                    TextSpan(
                                        text: statements[index].description,
                                        style: TextStyle()),
                                  ])),
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
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18),
                                            children: [
                                          TextSpan(
                                              text: (statements[index].amount /
                                                      100)
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    statements[index].amount > 0
                                                        ? Colors.green
                                                        : Colors.red,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ])),
                                  ],
                                ),
                              ),
                              Expanded(
                                // flex: 2,
                                child: Icon(Icons.double_arrow_rounded),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                            children: [
                                          TextSpan(
                                              text: (statements[index].balance /
                                                      100)
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ])),
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
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: statements.length);
  }

  @override
  Widget build(BuildContext context) {
    return controller.progress
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: controller.accountDropDownValue,
                              items: _getAccountDropDownItems(),
                              onChanged: (value) {
                                controller.accountDropDownValue =
                                    value ?? 'NaN';
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () => {}, child: Text('chart'.tr)),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    children: [
                                  TextSpan(text: 'expenses'.tr)
                                ],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildStatementList(controller.statements),
                )
              ],
            ));
  }
}
