import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mono_management/src/util/mcc.dart';

class PieChartStatement {
  PieChartStatement(this.mcc, this.mccDesc, this.amount);

  final String mccDesc;
  final int amount;
  final int mcc;
  final Color color =
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

  factory PieChartStatement.fromMapEntry(MapEntry mapEntry) =>
      PieChartStatement(
        mapEntry.key,
        Mcc.getDescFromCode(mapEntry.key),
        ((mapEntry.value / 100).toInt()).abs(),
      );
}
