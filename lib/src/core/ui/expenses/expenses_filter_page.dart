import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/util/mcc.dart';

class ExpensesFilterPage extends GetView<HomeController> {
  const ExpensesFilterPage({Key? key}) : super(key: key);

  Widget _buildMccFilterList(List<MccFilter> filters) {
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
                title: Text(Mcc().getDescFromCode(filters[index].mcc)),
                // secondary: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '',
                //       style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.black54,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
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

  Widget _buildMccFilterPage() {
    return Column(
      children: [
        Expanded(child: _buildMccFilterList(controller.mccFilters)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: TextField(
            //controller: controller.currencyNameFilter,
            onChanged: (value) {
              //controller.currencyFilterSearch = value;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Localization.keyNameSearch.tr,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                  onPressed: () => {controller.showMccFilter = false},
                  child: Text(Localization.keyBack.tr)),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return controller.showMccFilter
        ? _buildMccFilterPage()
        : Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              Localization.keyDate.tr,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    // controller: controller.currencyNameFilter,
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: Localization.keyFrom.tr,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(Localization.keySelect.tr),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    // controller: controller.currencyNameFilter,
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: Localization.keyTo.tr,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(Localization.keySelect.tr),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              Localization.keyType.tr,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      textStyle: const TextStyle(fontSize: 12),
                                    ),
                                    child: Text(Localization.keyIncomes.tr),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    child: Text(Localization.keyExpenses.tr),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                    ),
                                    onPressed: () {},
                                    child: Text(Localization.keyAll.tr),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton (
                        onPressed: () => {controller.showMccFilter = true},
                        child: Text(Localization.keyMccFilter.tr)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () =>
                            {controller.showStatementFilter = false},
                        child: Text(Localization.keyBack.tr)),
                  )
                ],
              ),
            ],
          );
  }
}
