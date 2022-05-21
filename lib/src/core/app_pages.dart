import 'package:get/get.dart';
import 'package:mono_management/src/core/ui/charts/bar_chart.dart';
import 'package:mono_management/src/core/ui/charts/line_chart.dart';
import 'package:mono_management/src/core/ui/charts/pie_chart.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_controller.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_view.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/core/ui/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const Duration transitionDuration = Duration(milliseconds: 350);
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    GetPage(
      name: Routes.CURRENCY_RATES,
      page: () => CurrencyRatesView(),
      binding: BindingsBuilder.put(
        () => CurrencyRatesController(),
      ),
    ),
    GetPage(
      name: Routes.LINE_CHART,
      page: () => LineChartView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    // TODO: change to a separate controller
    GetPage(
      name: Routes.PIE_CHART,
      page: () => PieChartView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    // TODO: change to a separate controller
    GetPage(
      name: Routes.BAR_CHART,
      page: () => BarChartView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    // TODO: change to a separate controller
    // GetPage(name: Routes.EXPENSES_FILTER, page: () => HomeView(), binding: BindingsBuilder.put(() => HomeController())),
    // GetPage(name: Routes.CURRENCY_RATES, page: () => CurrencyRatesView(), binding: BindingsBuilder.put(() => CurrencyRatesController())),
    // GetPage(name: Routes.SPLASH, page: () => SplashScreen(), binding: BindingsBuilder.put(() => SplashController())),
    // GetPage(name: Routes.MAIN, page: () => MainScreen(), binding: BindingsBuilder.put(() => MainController())),
  ];
}
