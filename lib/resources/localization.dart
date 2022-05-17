import 'package:get/get.dart';

class Localization extends Translations {
  static const keyCountryUA = 'ua_UA';
  static const keyCountryUS = 'en_US';

  static const keyPenis = 'penis';
  static const keyAss = 'ass';
  static const keyUserInfo = 'user info';
  static const keyId = 'id';
  static const keyFullName = 'full name';
  static const keyCurrencyCode = 'currency code';
  static const keyCashbackType = 'cashback type';
  static const keyBalance = 'balance';
  static const keyCreditLimit = 'credit limit';
  static const keyType = 'type';
  static const keyIban = 'iban';
  static const keyCurrencyRates = 'currency rates';
  static const keyExpenses = 'expenses';
  static const keyBlack = 'black';
  static const keyWhite = 'white';
  static const keyFilter = 'filter';
  static const keyBuy = 'buy';
  static const keySell = 'sell';
  static const keyExchange = 'exchange';
  static const keyCharts = 'charts';
  static const keyList = 'list';
  static const keyCategoryChart = 'category chart';
  static const keyBalanceChart = 'balance chart';
  static const keyAmount = 'amount';

  @override
  Map<String, Map<String, String>> get keys => const {
        keyCountryUS: {
          keyPenis: 'Penis',
          keyAss: 'Ass',
          keyUserInfo: 'User info',
          keyId: 'ID',
          keyFullName: 'Full name',
          keyCurrencyCode: 'Currency',
          keyCashbackType: 'Cashback type',
          keyBalance: 'Balance',
          keyCreditLimit: 'Credit limit',
          keyType: 'Type',
          keyIban: 'IBAN',
          keyCurrencyRates: 'Currency rates',
          keyExpenses: 'Expenses',
          keyBlack: 'Black',
          keyWhite: 'White',
          keyFilter: 'Filter',
          keyBuy: 'Buy',
          keySell: 'Sell',
          keyExchange: 'Exchange',
          keyCharts: 'Charts',
          keyList: 'List',
          keyCategoryChart: 'Category Chart',
          keyBalanceChart: 'Balance Chart',
          keyAmount: 'Amount',
        },
        keyCountryUA: {
          keyPenis: 'Пісюн',
          keyAss: 'Срака',
          keyUserInfo: 'Персональні дані',
          keyId: 'ID',
          keyFullName: "Повне ім'я",
          keyCurrencyCode: 'Валюта',
          keyCashbackType: 'Тип кешбеку',
          keyBalance: 'Баланс',
          keyCreditLimit: 'Кредитний ліміт',
          keyType: 'Тип',
          keyIban: 'IBAN',
          keyCurrencyRates: 'Курси валют',
          keyExpenses: 'Виписки',
          keyBlack: 'Чорна',
          keyWhite: 'Біла',
          keyFilter: 'Фільтр',
          keyBuy: 'Купівля',
          keySell: 'Продаж',
          keyExchange: 'Обмін',
          keyCharts: 'Графіки',
          keyList: 'Список',
          keyCategoryChart: 'Графік по категоріям',
          keyBalanceChart: 'Графік по балансу',
          keyAmount: 'Сума',
        }
      };
}
