import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';
import 'package:mono_management/src/util/mcc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                                                      fontSize: 14),
                                                  children: [
                                                TextSpan(
                                                    text:
                                                        '${Currency.abbreviationFromCode(statements[index].currencyCode)}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ])),
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
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14),
                                                  children: [
                                                TextSpan(
                                                    text:
                                                        '${Mcc().getDescFromCode(statements[index].mcc)}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                      fontSize: 14),
                                                  children: [
                                                TextSpan(
                                                    text: DateFormat.yMd()
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                statements[index]
                                                                        .time *
                                                                    1000)),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
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

  Widget _buildMccFilterList(List<MccFilter> filters) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.black12),
              child: CheckboxListTile(
                value: filters[index].show,
                onChanged: (value) {
                  filters[index].show = value ?? true;
                  controller.update();
                },
                title: Text('${Mcc().getDescFromCode(filters[index].mcc)}'),
                // secondary: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '',
                //       style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.black54,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                // subtitle: Text('subtitle'),
                // controlAffinity: ListTileControlAffinity.platform,
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: filters.length);
  }

  @override
  Widget build(BuildContext context) {
    return controller.progress
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: controller.showMccFilter
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () =>
                                    {controller.showMccFilter = false},
                                child: Text(Localization.keyList.tr)),
                          )
                        ],
                      ),
                      Expanded(
                          child: _buildMccFilterList(controller.mccFilters)),
                    ],
                  )
                : controller.showExpenseCharts
                    ? Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: () => {
                                            controller.showExpenseCharts = false
                                          },
                                      child: Text(Localization.keyList.tr)),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () => {},
                                    child:
                                        Text(Localization.keyCategoryChart.tr)),
                              )
                            ],
                          ),
                          Expanded(
                            child: Container(
                              child: SfCartesianChart(
                                primaryXAxis: NumericAxis(),
                                // primaryYAxis: NumericAxis(),
                                title: ChartTitle(
                                    text: Localization.keyBalanceChart.tr),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                ),
                                zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true,
                                    enableDoubleTapZooming: true,
                                    enablePanning: true),
                                series: <ChartSeries<Statement, int>>[
                                  LineSeries<Statement, int>(
                                      name: Localization.keyBalance.tr,
                                      dataSource: controller.statements,
                                      xValueMapper: (Statement statement, _) =>
                                          statement.time,
                                      yValueMapper: (Statement statement, _) =>
                                          statement.balance),
                                  LineSeries<Statement, int>(
                                      name: Localization.keyAmount.tr,
                                      dataSource: controller.statements,
                                      xValueMapper: (Statement statement, _) =>
                                          statement.time,
                                      yValueMapper: (Statement statement, _) =>
                                          statement.amount),
                                ],
                                axisLabelFormatter:
                                    (AxisLabelRenderDetails args) {
                                  late String text;
                                  if (args.axisName == 'primaryXAxis') {
                                    text = DateFormat.yMd().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            args.value.toInt() * 1000));
                                  } else {
                                    text = '${args.value / 100}';
                                  }
                                  return ChartAxisLabel(text, args.textStyle);
                                },
                                onTooltipRender: (TooltipArgs args) {
                                  args.text = 'NaN';
                                  var dataPoints = args.dataPoints;
                                  if (dataPoints != null &&
                                      dataPoints.isNotEmpty) {
                                    CartesianChartPoint point =
                                        dataPoints.elementAt(
                                            args.pointIndex?.toInt() ?? 0);
                                    args.text =
                                        '${DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(point.x * 1000))} : ${point.y / 100}';
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Column(
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
                                        onPressed: () =>
                                            {controller.showMccFilter = true},
                                        child: Text('type filter'.tr)),
                                  ),
                                  Expanded(
                                    child: OutlinedButton(
                                        onPressed: () => {
                                              controller.showExpenseCharts =
                                                  true
                                            },
                                        child: Text('charts'.tr)),
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
                                          TextSpan(
                                              text: Localization.keyExpenses.tr)
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
                          Expanded(
                            child: _buildStatementList(
                                controller.getFilteredStatements()),
                          )
                        ],
                      ));
  }
}
