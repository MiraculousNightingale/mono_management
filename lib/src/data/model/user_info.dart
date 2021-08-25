// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.clientId = '',
    this.name = '',
    this.webHookUrl = '',
    this.permissions = '',
    this.accounts = const <Account>[],
  });

  String clientId;
  String name;
  String webHookUrl;
  String permissions;
  List<Account> accounts;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        clientId: json["clientId"],
        name: json["name"],
        webHookUrl: json["webHookUrl"],
        permissions: json["permissions"],
        accounts: List<Account>.from(
            json["accounts"].map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "name": name,
        "webHookUrl": webHookUrl,
        "permissions": permissions,
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
      };
}

class Account {
  Account({
    this.id = '',
    this.sendId = '',
    this.currencyCode = 0,
    this.cashbackType = '',
    this.balance = 0,
    this.creditLimit = 0,
    this.maskedPan = const <String>[],
    this.type = '',
    this.iban = '',
  });

  String id;
  String sendId;
  int currencyCode;
  String cashbackType;
  int balance;
  int creditLimit;
  List<String> maskedPan;
  String type;
  String iban;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        sendId: json["sendId"],
        currencyCode: json["currencyCode"],
        cashbackType: json["cashbackType"],
        balance: json["balance"],
        creditLimit: json["creditLimit"],
        maskedPan: List<String>.from(json["maskedPan"].map((x) => x)),
        type: json["type"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sendId": sendId,
        "currencyCode": currencyCode,
        "cashbackType": cashbackType,
        "balance": balance,
        "creditLimit": creditLimit,
        "maskedPan": List<dynamic>.from(maskedPan.map((x) => x)),
        "type": type,
        "iban": iban,
      };
}
