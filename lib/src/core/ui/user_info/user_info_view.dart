import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
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
      options: CarouselOptions(
          enlargeCenterPage: true, viewportFraction: 0.81, height: 235),
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
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ]
                : null,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(),
            color: const Color.fromARGB(255, 225, 225, 225),
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
                        padding: const EdgeInsets.only(right: 5),
                        child: RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black54),
                                children: [
                              TextSpan(
                                  text: '${'currency code'.tr}: ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: Currency.abbreviationFromCode(
                                    accounts[accountIndex].currencyCode),
                              ),
                            ]))),
                    Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black54),
                                children: [
                              TextSpan(
                                  text: '${'cashback type'.tr}: ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: accounts[accountIndex].cashbackType,
                              ),
                            ]))),
                  ],
                ),
                leading: const Icon(
                  Icons.credit_card,
                ),
                //contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              ),
              ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text: '${'balance'.tr}: ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              '${accounts[accountIndex].balance / 100}')
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
                                      text: '${'credit limit'.tr}: ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            '${accounts[accountIndex].creditLimit}'),
                                  ],
                                ),
                              ),
                            ),
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
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: accounts[accountIndex].type.tr,
                                      ),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: accounts[accountIndex].iban,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return controller.progress
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // ListTile(
                      //   title:
                      //       Text("${'id'.tr}: ${controller.userInfo.clientId}"),
                      //   focusColor: Colors.black,
                      // ),
                      //TODO: Replace placeholder
                      ListTile(
                        title: RichText(
                          text: TextSpan(
                            text: '${Localization.keyFullName.tr}: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: controller.userInfo.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //     "${'full name'.tr}: ${controller.userInfo.name}"),
                      ),
                      ListTile(
                        title: RichText(
                          text: const TextSpan(
                            text: 'Кількість карток: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: '3',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: RichText(
                          text: TextSpan(
                            text: 'Зміна за останні 7 днів: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${(controller.last7DaysChange / 100).round().toString()} UAH',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ListTile(
                      //   title: Text(
                      //       "${'full name'.tr}: ${controller.userInfo.name}"),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildAccountList(controller.userInfo.accounts),
                ),
              ],
            ),
          );
  }
}
