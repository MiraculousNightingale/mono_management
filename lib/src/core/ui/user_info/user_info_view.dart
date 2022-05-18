import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/resources/test_styles.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

class UserInfoView extends GetView<HomeController> {
  const UserInfoView({Key? key}) : super(key: key);

  Widget _buildAccountList(List<Account> accounts) {
    return CarouselSlider.builder(
      itemCount: controller.userInfo.accounts.length,
      itemBuilder: (context, index, realIndex) {
        return _buildAccountCard(index, context);
      },
      options: CarouselOptions(enlargeCenterPage: false, viewportFraction: 0.9, height: 220),
    );
  }

  Widget _buildAccountCard(int accountIndex, BuildContext context) {
    final accounts = controller.userInfo.accounts;
    return InkWell(
      onTap: () {
        controller.setSelectedAccount(accountIndex);
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            boxShadow: accountIndex == controller.selectedAccountId
                ? [
                    const BoxShadow(
                      color: Colors.green,
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ]
                : null,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: Colors.black),
            color: Color.fromARGB(255, 225, 225, 225),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  accounts[accountIndex].maskedPan.elementAt(0),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  controller.setSelectedAccount(accountIndex);
                },
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black54),
                                children: [
                              TextSpan(
                                  text: '${'currency code'.tr}: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text:
                                    '${Currency.abbreviationFromCode(accounts[accountIndex].currencyCode)}',
                              ),
                            ])),
                        padding: const EdgeInsets.only(right: 5)),
                    Container(
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black54),
                                children: [
                              TextSpan(
                                  text: '${'cashback type'.tr}: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: '${accounts[accountIndex].cashbackType}',
                              ),
                            ])),
                        padding: const EdgeInsets.only(right: 5)),
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
                                            '${accounts[accountIndex].balance / 100}')
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.only(right: 5)),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
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
                                            '${accounts[accountIndex].creditLimit}')
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
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                        text: '${'type'.tr}: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            '${accounts[accountIndex].type.tr}')
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
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                        text: '${'iban'.tr}: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '${accounts[accountIndex].iban}')
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.only(right: 5)),
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
