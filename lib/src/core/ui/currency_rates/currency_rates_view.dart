import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/data/model/user_info.dart';
import 'package:mono_management/src/util/currencies.dart';

import '../../app_pages.dart';

class CurrencyRatesView extends GetView<HomeController> {
  Widget _showExhangeRate(CurrencyRate currencyRate) {
    return currencyRate.rateCross == 0.0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_rounded),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black87),
                          children: [
                        TextSpan(
                            text: ' ${'buy'.tr}: ${currencyRate.rateBuy} ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black87),
                          children: [
                        TextSpan(
                            text: ' ${'sell'.tr}: ${currencyRate.rateSell} ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ],
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.compare_arrows_rounded),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: ' ${'exchange'.tr}: ${currencyRate.rateCross} ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  Icon(Icons.compare_arrows_rounded),
                ],
              ),
            ],
          );
  }

  Widget _buildCurrencyRateList(List<CurrencyRate> currencyRates) {
    //TODO: Debug stuff, don't forget to remove
    // accounts.add(accounts.first);
    // accounts.add(accounts.first);
    // accounts.add(accounts.first);
    // accounts.add(accounts.first);
    // accounts.add(accounts.first);

    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.black12),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 18),
                                      children: [
                                    TextSpan(
                                        text:
                                            '${Currency().symbolFromCode(currencyRates[index].currencyCodeA)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            // ' ${currencyRates[index].currencyCodeA} '),
                                            '  '),
                                    TextSpan(
                                      text:
                                          '${Currency().abbreviationFromCode(currencyRates[index].currencyCodeA)}',
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: _showExhangeRate(currencyRates[index]),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 18),
                                      children: [
                                    TextSpan(
                                        text:
                                            '${Currency().symbolFromCode(currencyRates[index].currencyCodeB)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            // ' ${currencyRates[index].currencyCodeA} '),
                                            '  '),
                                    TextSpan(
                                      text:
                                          '${Currency().abbreviationFromCode(currencyRates[index].currencyCodeB)}',
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: currencyRates.length);
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
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () => {}, child: Text('filter'.tr)),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    children: [
                                  TextSpan(text: 'currency rates'.tr)
                                ],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildCurrencyRateList(controller.currencyRates),
                )
              ],
            ));
  }
}
