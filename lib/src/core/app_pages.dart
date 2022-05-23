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
  static const initialRoute = Routes.honeRoute;

  static final routes = [
    GetPage(
      name: Routes.honeRoute,
      page: () => const HomeView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    GetPage(
      name: Routes.currencyRatesRoute,
      page: () => const CurrencyRatesView(),
      binding: BindingsBuilder.put(
        () => CurrencyRatesController(),
      ),
    ),
    GetPage(
      name: Routes.lineChartRoute,
      page: () => const LineChartView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    // TODO: change to a separate controller
    GetPage(
      name: Routes.pieChartRoute,
      page: () => const PieChartView(),
      binding: BindingsBuilder.put(
        () => HomeController(),
      ),
    ),
    // TODO: change to a separate controller
    GetPage(
      name: Routes.barChartRote,
      page: () => const BarChartView(),
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
