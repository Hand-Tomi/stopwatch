import 'package:hive/hive.dart';

import '../table.dart';

class TableImpl<T> extends Table {
  Box<T> box;
  TableImpl(this.box);
}
