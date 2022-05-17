import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

import '../../app_pages.dart';

class UserInfoView extends GetView<HomeController> {
  Widget _buildAccountList(List<Account> accounts) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.setSelectedAccount(index);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: index == controller.selectedAccountId ? [
                    const BoxShadow(
                      color: Colors.green,
                      offset: const Offset(0,0),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ] : null,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: Colors.black),
                    color: Color.fromARGB(255, 225, 225, 225),),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        accounts[index].maskedPan.elementAt(0),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        controller.setSelectedAccount(index);
                      },
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black54),
                                      children: [
                                    TextSpan(
                                        text: '${'currency code'.tr}: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text:
                                          Currency.abbreviationFromCode(accounts[index].currencyCode),
                                    ),
                                  ]))),
                          Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black54),
                                      children: [
                                    TextSpan(
                                        text: '${'cashback type'.tr}: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: '${accounts[index].cashbackType}',
                                    ),
                                  ]))),
                        ],
                      ),
                      leading: Icon(
                        Icons.credit_card,
                      ),
                      //contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    ),
                    ListTile(
                        title: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text: '${'balance'.tr}: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  '${accounts[index].balance / 100}')
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(right: 5)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text: '${'credit limit'.tr}: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  '${accounts[index].creditLimit}')
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text: '${'type'.tr}: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: '${accounts[index].type.tr}')
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text: '${'iban'.tr}: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: '${accounts[index].iban}')
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ))
                  ],
                )),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: accounts.length);
  }

  @override
  Widget build(BuildContext context) {
    return controller.progress
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        title:
                            Text("${'id'.tr}: ${controller.userInfo.clientId}"),
                        focusColor: Colors.black,
                      ),
                      ListTile(
                          title: Text(
                              "${'full name'.tr}: ${controller.userInfo.name}")),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildAccountList(controller.userInfo.accounts),
                )
              ],
            ));
  }
}
