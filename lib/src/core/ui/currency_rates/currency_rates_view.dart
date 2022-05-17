import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/test_styles.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/currency_filter.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/util/currencies.dart';

class CurrencyRatesView extends GetView<HomeController> {
  Widget _showExhangeRate(CurrencyRate currencyRate) {
    return currencyRate.rateCross == 0.0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back_rounded),
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
                            style: GoogleFonts.roboto(
                                textStyle: TextStyles.black14w600)),
                      ])),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ],
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.compare_arrows_rounded),
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.roboto(
                              textStyle: TextStyles.black14w400),
                          children: [
                        TextSpan(
                          text: ' ${'exchange'.tr}: ${currencyRate.rateCross} ',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyles.black14w600),
                        ),
                      ])),
                  const Icon(Icons.compare_arrows_rounded),
                ],
              ),
            ],
          );
  }

  Widget _buildCurrencyFilterList(List<CurrencyFilter> filters) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.black12),
              child: CheckboxListTile(
                value: filters[index].show,
                onChanged: (value) {
                  filters[index].show = value ?? true;
                  controller.update();
                },
                title: Text(Currency.nameFromCode(filters[index].currencyCode)),
                secondary: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${Currency.symbolFromCode(filters[index].currencyCode)} ${Currency.abbreviationFromCode(filters[index].currencyCode)}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // subtitle: Text('subtitle'),
                // controlAffinity: ListTileControlAffinity.platform,
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: filters.length);
  }

  Widget _buildCurrencyRateList(List<CurrencyRate> currencyRates) {
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
                                        text: Currency.symbolFromCode(
                                            currencyRates[index].currencyCodeA),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            // ' ${currencyRates[index].currencyCodeA} '),
                                            ' '),
                                    TextSpan(
                                      text: Currency.abbreviationFromCode(
                                          currencyRates[index].currencyCodeA),
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
                                        text: Currency.symbolFromCode(
                                            currencyRates[index].currencyCodeB),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            // ' ${currencyRates[index].currencyCodeA} '),
                                            ' '),
                                    TextSpan(
                                      text: Currency.abbreviationFromCode(
                                          currencyRates[index].currencyCodeB),
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
                            child: controller.showCurrencyFilter
                                ? OutlinedButton(
                                    onPressed: () =>
                                        {controller.showCurrencyFilter = false},
                                    child: Text('back to currency list'.tr))
                                : OutlinedButton(
                                    onPressed: () =>
                                        {controller.showCurrencyFilter = true},
                                    child: Text('filter'.tr)),
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
                  child: controller.showCurrencyFilter
                      ? _buildCurrencyFilterList(controller.currencyFilters)
                      : _buildCurrencyRateList(
                          controller.getFilteredCurrencyRates()),
                )
              ],
            ));
  }
}
