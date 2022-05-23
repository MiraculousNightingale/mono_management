part of 'app_pages.dart';

abstract class Routes {
  static const splashRoute = '/';
  static const loginRoute = '/login';
  static const registrationRoute = '/registration';
  static const homeRoute = '/home';
  static const lineChartRoute = '/line_chart';
  static const pieChartRoute = '/pie_chart';
  static const barChartRote = '/bar_chart';
  static const currencyRatesRoute = '/currency_rates';
  static const expensesFilterRoute = '/expenses_filter';

  static bool isLogoutRoute(String route) =>
      route == loginRoute || route == registrationRoute;
}