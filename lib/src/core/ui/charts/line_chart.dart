import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartView extends GetView<HomeController>{
  const LineChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(Localization.keyLineChart.tr),
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
                  primaryXAxis: NumericAxis(),
                  // primaryYAxis: NumericAxis(),
                  title: ChartTitle(text: Localization.keyBalanceChart.tr),
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
                  axisLabelFormatter: (AxisLabelRenderDetails args) {
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
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () => {Get.toNamed(Routes.honeRoute)},
                        child: Text(Localization.keyBack.tr)),
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