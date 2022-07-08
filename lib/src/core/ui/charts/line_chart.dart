import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/charts/chart_controller.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartView extends GetView<ChartController>{
  const LineChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(Localization.lineChart.tr),
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
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.yMd(),
                  ),
                  primaryYAxis: NumericAxis(

                  ),
                  // primaryYAxis: NumericAxis(),
                  title: ChartTitle(text: Localization.balanceChart.tr),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true,
                      enableDoubleTapZooming: true,
                      enablePanning: true),
                  series: <ChartSeries<Statement, DateTime>>[
                    LineSeries<Statement, DateTime>(
                        name: Localization.balance.tr,
                        dataSource: controller.statements,
                        xValueMapper: (Statement statement, _) =>
                            DateTime.fromMillisecondsSinceEpoch(statement.time * 1000),
                        yValueMapper: (Statement statement, _) =>
                            (statement.balance/100).round()),
                    LineSeries<Statement, DateTime>(
                        name: Localization.amount.tr,
                        dataSource: controller.statements,
                        xValueMapper: (Statement statement, _) =>
                            DateTime.fromMillisecondsSinceEpoch(statement.time * 1000),
                        yValueMapper: (Statement statement, _) =>
                            (statement.amount/100).round()),
                  ],

                  // axisLabelFormatter: (AxisLabelRenderDetails args) {
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
                  onTooltipRender: (TooltipArgs args) {
                    args.text = 'NaN';
                    final List<dynamic>? dataPoints = args.dataPoints;
                    if (dataPoints != null && dataPoints.isNotEmpty) {
                      final CartesianChartPoint point =
                          dataPoints.elementAt(args.pointIndex?.toInt() ?? 0);
                      args.text =
                          '${DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(point.x * 1000))} : ${point.y / 100}';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 35,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller:
                        controller.filterDateRangeTextController,
                        //onChanged: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: Localization.date.tr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
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