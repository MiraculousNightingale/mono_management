import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/colors.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/resources/test_styles.dart';
import 'package:mono_management/src/core/app_pages.dart';
import 'package:mono_management/src/core/ui/common/botnavbar.dart';
import 'package:mono_management/src/core/ui/common/navigation_drawer.dart';
import 'package:mono_management/src/core/ui/currency_rates/currency_rates_controller.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/currency_filter.dart';
import 'package:mono_management/src/data/model/currency_rate.dart';
import 'package:mono_management/src/util/currencies.dart';

class CurrencyRatesView extends GetView<CurrencyRatesController> {
  const CurrencyRatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencyRatesController>(
      //TODO: Remove async data load
      builder: (controller) => controller.progress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  controller.getCurrentTitle(),
                ),
                backgroundColor: appBarColor,
              ),
              drawer: NavigationDrawer(
                userInfo: controller.userInfo,
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: controller.showCurrencyFilter
                          ? _buildCurrencyFilterPage(
                              controller.currencyFilters,
                            )
                          : _buildCurrencyRateList(
                              controller.getFilteredCurrencyRates(),
                            ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: controller.showCurrencyFilter
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          controller.showCurrencyFilter = false
                                        },
                                        child: Text(Localization.back.tr),
                                      ),
                                    ),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          controller
                                              .setCurrencyFiltersVisibility(
                                                  false)
                                        },
                                        child: Text('none'.tr),
                                      ),
                                    ),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          controller
                                              .setCurrencyFiltersVisibility(
                                                  true)
                                        },
                                        child: Text('all'.tr),
                                      ),
                                    ),
                                  ],
                                )
                              : OutlinedButton(
                                  onPressed: () =>
                                      {controller.showCurrencyFilter = true},
                                  child: Text(Localization.filter.tr)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: const BotNavBar(
                currentIndex: 1,
              ),
            ),
    );
  }

  Widget _showExchangeRate(CurrencyRate currencyRate) {
    return currencyRate.rateCross == 0.0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back_rounded),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black87),
                          children: [
                        TextSpan(
                          text:
                              ' ${Localization.buy.tr}: ${currencyRate.rateBuy} ',
                          style: TextStyles.black14w400,
                        ),
                      ])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                            text:
                                ' ${Localization.sell.tr}: ${currencyRate.rateSell} ',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyles.black14w600)),
                      ],
                    ),
                  ),
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
                          text:
                              ' ${Localization.exchange.tr}: ${currencyRate.rateCross} ',
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

  Widget _buildCurrencyFilterPage(List<CurrencyFilter> filters) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.black12,
                ),
                child: CheckboxListTile(
                  value: filters[index].show,
                  onChanged: (value) {
                    filters[index].show = value ?? true;
                    controller.update();
                  },
                  title:
                      Text(Currency.nameFromCode(filters[index].currencyCode)),
                  secondary: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${Currency.symbolFromCode(filters[index].currencyCode)} ${Currency.abbreviationFromCode(filters[index].currencyCode)}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // subtitle: Text('subtitle'),
                  // controlAffinity: ListTileControlAffinity.platform,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: filters.length,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: TextField(
            // controller: controller.currencyNameFilter,
            onChanged: (value) {
              controller.currencyFilterSearch = value;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Localization.currencySearch.tr,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyRateList(List<CurrencyRate> currencyRates) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17), color: Colors.black12),
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
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              children: [
                                TextSpan(
                                  text: Currency.symbolFromCode(
                                    currencyRates[index].currencyCodeA,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                    text:
                                        // ' ${currencyRates[index].currencyCodeA} '),
                                        ' '),
                                TextSpan(
                                  text: Currency.abbreviationFromCode(
                                      currencyRates[index].currencyCodeA),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _showExchangeRate(currencyRates[index]),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 18),
                              children: [
                                TextSpan(
                                    text: Currency.symbolFromCode(
                                        currencyRates[index].currencyCodeB),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const TextSpan(
                                    text:
                                        // ' ${currencyRates[index].currencyCodeA} '),
                                        ' '),
                                TextSpan(
                                  text: Currency.abbreviationFromCode(
                                      currencyRates[index].currencyCodeB),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: currencyRates.length,
    );
  }
}
