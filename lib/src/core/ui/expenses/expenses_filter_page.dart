import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_management/resources/localization.dart';
import 'package:mono_management/src/core/ui/expenses/expenses_controller.dart';
import 'package:mono_management/src/core/ui/home/home_controller.dart';
import 'package:mono_management/src/data/model/mcc_filter.dart';
import 'package:mono_management/src/data/model/statement.dart';
import 'package:mono_management/src/util/mcc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ExpensesFilterPage extends StatelessWidget {
  const ExpensesFilterPage({required this.controller, Key? key})
      : super(key: key);
  final ExpensesController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.showMccFilter) {
      return _buildMccFilterPage();
    }
    if (controller.showDatePickerDialog) {
      return _buildDatePickerPage();
    }
    return Column(
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
                        Localization.date.tr,
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
                              controller: controller.dateRangeController,
                              //onChanged: (value) {},
                              enabled: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: Localization.date.tr,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                {controller.showDatePickerDialog = true},
                            child: Text(Localization.select.tr),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Text(
                        Localization.type.tr,
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
                              onPressed: () => {
                                controller.filterStatementType =
                                    StatementOperationType.deposit
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              child: Text(Localization.incomes.tr),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => {
                                controller.filterStatementType =
                                    StatementOperationType.withdrawal
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: Text(Localization.expenses.tr),
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
                              onPressed: () => {
                                controller.filterStatementType =
                                    StatementOperationType.all
                              },
                              child: Text(Localization.all.tr),
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
              child: ElevatedButton(
                  onPressed: () => {controller.showMccFilter = true},
                  child: Text(Localization.mccFilter.tr)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                  onPressed: () => {controller.showStatementFilter = false},
                  child: Text(Localization.back.tr)),
            ),
          ],
        ),
      ],
    );
  }

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
                title: Text(Mcc.getDescFromCode(filters[index].mcc)),
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
        Expanded(child: _buildMccFilterList(controller.filteredMccFilters)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 45,
          child: TextField(
            //controller: controller.currencyNameFilter,
            onChanged: (value) {
              controller.searchMccFilterName = value;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Localization.nameSearch.tr,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                  onPressed: () => {controller.showMccFilter = false},
                  child: Text(Localization.back.tr)),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildDatePickerPage() {
    return Column(
      children: [
        Expanded(
          child: SfDateRangePicker(
            view: DateRangePickerView.year,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              final PickerDateRange value = args.value;
              controller.filterStatementDateRange = value;
              controller.dateRangeController.text =
                  '${Localization.from.tr} ${DateFormat.yMd().format(value.startDate!)} ${Localization.to.tr.toLowerCase()} ${DateFormat.yMd().format(value.endDate!)}';
            },
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => {controller.showDatePickerDialog = false},
                child: Text(Localization.back.tr),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
