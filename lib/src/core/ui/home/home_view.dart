import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/user_info.dart';

class HomeView extends GetView<HomeController> {
  Widget _buildAccountList(List<Account> accounts) {
    accounts.add(accounts.first);
    accounts.add(accounts.first);
    accounts.add(accounts.first);
    accounts.add(accounts.first);
    accounts.add(accounts.first);

    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
              child: Column(
                children: [
                  ListTile(
                    title: Text(accounts[index].maskedPan.elementAt(0)),
                    subtitle: Row(
                      children: [
                        Container(
                            child: Text(
                                '${'currency code'.tr}: ${accounts[index].currencyCode.toString()}'),
                            padding: const EdgeInsets.only(right: 5)),
                        Container(
                            child: Text(
                                '${'cashback type'.tr}: ${accounts[index].cashbackType}'),
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
                                  child: Text(
                                      '${'balance'.tr}: ${accounts[index].balance}'),
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
                                  child: Text(
                                      '${'credit limit'.tr}: ${accounts[index].creditLimit}'),
                                  padding: const EdgeInsets.only(right: 5)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  child: Text(
                                      '${'type'.tr}: ${accounts[index].type}'),
                                  padding: const EdgeInsets.only(right: 5)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  child: Text(
                                      '${'iban'.tr}: ${accounts[index].iban}'),
                                  padding: const EdgeInsets.only(right: 5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('user info'.tr),
      ),
      body: controller.progress
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
                          title: Text(
                              "${'id'.tr}: ${controller.userInfo.clientId}"),
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
              )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'user info'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows), label: 'currency rates'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'expenses'.tr),
        ],
      ),
    );
  }
}
