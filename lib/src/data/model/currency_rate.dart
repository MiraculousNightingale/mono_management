import 'dart:collection';
import 'dart:convert';

CurrencyRate currencyRateFromJson(String str) => CurrencyRate.fromJson(json.decode(str));

String currencyRateToJson(CurrencyRate data) => json.encode(data.toJson());

class CurrencyRate {
  CurrencyRate({
    this.currencyCodeA = 0,
    this.currencyCodeB = 0,
    this.date = 0,
    this.rateBuy = 0.0,
    this.rateSell = 0.0,
    this.rateCross = 0.0,
  });

  int currencyCodeA;
  int currencyCodeB;
  int date;
  double rateBuy;
  double rateSell;
  double rateCross;

  factory CurrencyRate.fromJson(Map<String, dynamic> json) => CurrencyRate(
    currencyCodeA: json["currencyCodeA"],
    currencyCodeB: json["currencyCodeB"],
    date: json["date"],
    rateBuy: json["rateBuy"].toDouble(),
    rateSell: json["rateSell"].toDouble(),
    rateCross: json["rateCross"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "currencyCodeA": currencyCodeA,
    "currencyCodeB": currencyCodeB,
    "date": date,
    "rateBuy": rateBuy,
    "rateSell": rateSell,
    "rateCross": rateCross,
  };
}
