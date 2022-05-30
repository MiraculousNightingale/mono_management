import 'package:mono_management/src/util/currencies.dart';

class CurrencyFilter {
  CurrencyFilter(this.currencyCode, this.show)
      : currencyName = Currency.nameFromCode(currencyCode),
       currencyNameLc = Currency.nameFromCode(currencyCode).toLowerCase(),
        currencyAbbreviation = Currency.abbreviationFromCode(currencyCode),
        currencyAbbreviationLc = Currency.abbreviationFromCode(currencyCode).toLowerCase();

  final int currencyCode;
  final String currencyName;
  final String currencyNameLc;
  final String currencyAbbreviation;
  final String currencyAbbreviationLc;
  bool show = true;

}
