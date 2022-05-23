import 'package:get/get.dart';
import 'package:mono_management/src/core/ui/charts/bar_chart.dart';
import 'package:mono_management/src/core/ui/charts/line_chart.dart';
import 'package:mono_management/src/core/ui/charts/pie_chart.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_controller.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_view.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/core/ui/home/home_view.dart';
import 'package:mono_management/src/core/ui/login/login/login_controller.dart';
import 'package:mono_management/src/core/ui/login/login/login_view.dart';
import 'package:mono_management/src/core/ui/login/register/registration_controller.dart';
import 'package:mono_management/src/core/ui/login/register/registration_view.dart';
import 'package:mono_management/src/core/ui/splash/splash_controller.dart';
import 'package:mono_management/src/core/ui/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const Duration transitionDuration = Duration(milliseconds: 350);
  static const initialRoute = Routes.splashRoute;

  static final routes = [
    GetPage(
      name: Routes.splashRoute,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(
        () => SplashController(),
      ),
    ),
    GetPage(
      name: Routes.loginRoute,
      page: () => const LoginView(),
      binding: BindingsBuilder.put(
        () => LoginController(),
      ),
    ),
    GetPage(
      name: Routes.registrationRoute,
      page: () => const RegistrationView(),
      binding: BindingsBuilder.put(
        () => RegistrationController(),
      ),
    ),
    GetPage(
      name: Routes.homeRoute,
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
