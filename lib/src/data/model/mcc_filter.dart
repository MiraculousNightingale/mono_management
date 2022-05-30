import 'package:mono_management/src/util/mcc.dart';

class MccFilter {
  MccFilter(this.mcc, this.show)
      : name = Mcc.getDescFromCode(mcc),
        nameLc = Mcc.getDescFromCode(mcc).toLowerCase();

  final int mcc;
  final String name;
  final String nameLc;

  bool show = true;
}
