// To parse this JSON data, do
//
//     final statement = statementFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

Statement statementFromJson(String str) => Statement.fromJson(json.decode(str));

String statementToJson(Statement data) => json.encode(data.toJson());

enum StatementOperationType {
  deposit,
  withdrawal,
  all,
}

class Statement {
  Statement({
    this.id = '',
    this.time = 0,
    this.description = '',
    this.comment = '',
    this.mcc = 0,
    this.originalMcc = 0,
    this.amount = 0,
    this.operationAmount = 0,
    this.currencyCode = 0,
    this.commissionRate = 0,
    this.cashbackAmount = 0,
    this.balance = 0,
    this.hold = false,
    this.receiptId = '',
    this.counterEdrpou = '',
    this.counterIban = '',
  });

  String id;
  int time;
  String description;
  String comment;
  int mcc;
  int originalMcc;
  int amount;
  int operationAmount;
  int currencyCode;
  int commissionRate;
  int cashbackAmount;
  int balance;
  bool hold;
  String receiptId;
  String counterEdrpou;
  String counterIban;

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
        id: json["id"],
        time: json["time"],
        description: json["description"],
        comment: json["comment"],
        mcc: json["mcc"],
        originalMcc: json["originalMcc"],
        amount: json["amount"],
        operationAmount: json["operationAmount"],
        currencyCode: json["currencyCode"],
        commissionRate: json["commissionRate"],
        cashbackAmount: json["cashbackAmount"],
        balance: json["balance"],
        hold: json["hold"],
        receiptId: json["receiptId"],
        counterEdrpou: json["counterEdrpou"],
        counterIban: json["counterIban"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "description": description,
        "comment": comment,
        "mcc": mcc,
        "originalMcc": originalMcc,
        "amount": amount,
        "operationAmount": operationAmount,
        "currencyCode": currencyCode,
        "commissionRate": commissionRate,
        "cashbackAmount": cashbackAmount,
        "balance": balance,
        "hold": hold,
        "receiptId": receiptId,
        "counterEdrpou": counterEdrpou,
        "counterIban": counterIban,
      };

  String getDateInFormat() {
    return DateFormat.yMd()
        .format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
  }
  DateTime getDateInDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(time * 1000);
  }
}
