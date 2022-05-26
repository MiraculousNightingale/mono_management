import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/expenses/expenses_filter_page.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/util/currencies.dart';
import 'package:mono_management/src/util/mcc.dart';

class ExpensesView extends GetView<HomeController> {
  const ExpensesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.progress
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: controller.showStatementFilter
                ? ExpensesFilterPage(
                    controller: controller,
                  )
                : Column(
                    children: [
                      Expanded(
                        child: _buildStatementList(
                          controller.getFilteredStatements(),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: controller.currencyNameFilter,
                              onChanged: (value) {
                                controller.currencyFilterSearch = value;
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: Localization.descriptionSearch.tr,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    controller.showStatementFilter = true;
                                  },
                                  child: Text(Localization.filter.tr),
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   decoration: const BoxDecoration(),
                          //   padding: const EdgeInsets.all(10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       RichText(
                          //         text: TextSpan(
                          //           children: [
                          //             TextSpan(
                          //               text: Localization.keyExpenses.tr,
                          //             )
                          //           ],
                          //           style: const TextStyle(
                          //             color: Colors.black,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
          );
  }

  // List<DropdownMenuItem<String>> _getAccountDropDownItems() {
  //   List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
  //   items.add(DropdownMenuItem<String>(
  //     child: Text('select account'.tr),
  //     value: 'NaN',
  //   ));
  //   for (Account account in controller.userInfo.accounts) {
  //     items.add(DropdownMenuItem<String>(
  //       child: Text('${account.maskedPan}'),
  //       value: account.id,
  //     ));
  //   }
  //   return items;
  // }

  Widget _buildStatementList(List<Statement> statements) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
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
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14),
                                            children: [
                                              TextSpan(
                                                text: Currency
                                                    .abbreviationFromCode(
                                                        statements[index]
                                                            .currencyCode),
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
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14),
                                            children: [
                                              TextSpan(
                                                text: Mcc.getDescFromCode(
                                                    statements[index].mcc),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14),
                                            children: [
                                              TextSpan(
                                                  text: DateFormat.yMd().format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            statements[index]
                                                                    .time *
                                                                1000),
                                                  ),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
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
                                      text: statements[index].description,
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
                                          text: (statements[index].amount / 100)
                                              .toString(),
                                          style: TextStyle(
                                            color: statements[index].amount > 0
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
                                          text:
                                              (statements[index].balance / 100)
                                                  .toString(),
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
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: statements.length);
  }
}
