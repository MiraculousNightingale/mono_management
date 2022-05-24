import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/pie_chart_statement.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartView extends GetView<HomeController> {
  const BarChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(Localization.barChart.tr),
          backgroundColor: Colors.black,
        ),
        drawer: NavigationDrawer(
          userInfo: controller.userInfo,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelRotation: 90,
                  ),

                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: [
                    StackedColumnSeries<PieChartStatement, String>(
                      name: Localization.expenses.tr,
                      dataSource: controller.pieChartStatementData,
                      xValueMapper: (PieChartStatement element, _) =>
                          element.mccDesc,
                      yValueMapper: (PieChartStatement element, _) =>
                          element.amount,
                      pointColorMapper: (PieChartStatement element, _) =>
                          element.color,
                    ),

                    // BarSeries<PieChartStatement, int>(
                    //   dataSource: controller.pieChartStatementData,
                    //   xValueMapper: (PieChartStatement element, _) =>
                    //       element.mcc,
                    //   yValueMapper: (PieChartStatement element, _) =>
                    //       element.amount,
                    //   dataLabelSettings:
                    //       const DataLabelSettings(isVisible: true),
                    // ),
                  ],
                  // primaryXAxis: NumericAxis(),
                  // // primaryYAxis: NumericAxis(),
                  // title: ChartTitle(
                  //     text: Localization.keyBalanceChart.tr),
                  // legend: Legend(isVisible: true),
                  // tooltipBehavior: TooltipBehavior(
                  //   enable: true,
                  // ),
                  // zoomPanBehavior: ZoomPanBehavior(
                  //     enablePinching: true,
                  //     enableDoubleTapZooming: true,
                  //     enablePanning: true),
                  // series: <ChartSeries<Statement, int>>[
                  //   LineSeries<Statement, int>(
                  //       name: Localization.keyBalance.tr,
                  //       dataSource: controller.statements,
                  //       xValueMapper: (Statement statement, _) =>
                  //       statement.time,
                  //       yValueMapper: (Statement statement, _) =>
                  //       statement.balance),
                  //   LineSeries<Statement, int>(
                  //       name: Localization.keyAmount.tr,
                  //       dataSource: controller.statements,
                  //       xValueMapper: (Statement statement, _) =>
                  //       statement.time,
                  //       yValueMapper: (Statement statement, _) =>
                  //       statement.amount),
                  // ],
                  // axisLabelFormatter:
                  //     (AxisLabelRenderDetails args) {
                  //   late String text;
                  //   if (args.axisName == 'primaryXAxis') {
                  //     text = DateFormat.yMd().format(
                  //         DateTime.fromMillisecondsSinceEpoch(
                  //             args.value.toInt() * 1000));
                  //   } else {
                  //     text = '${args.value / 100}';
                  //   }
                  //   return ChartAxisLabel(text, args.textStyle);
                  // },
                  // onTooltipRender: (TooltipArgs args) {
                  //   args.text = 'NaN';
                  //   var dataPoints = args.dataPoints;
                  //   if (dataPoints != null &&
                  //       dataPoints.isNotEmpty) {
                  //     CartesianChartPoint point =
                  //     dataPoints.elementAt(
                  //         args.pointIndex?.toInt() ?? 0);
                  //     args.text =
                  //     '${DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(point.x * 1000))} : ${point.y / 100}';
                  //   }
                  // },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () => {Get.toNamed(Routes.homeRoute)},
                        child: Text(Localization.back.tr)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
