import 'package:stopwatch/core/app_tables.dart';

import 'table.dart';

abstract class Database {
  void init();
  Future<Table<T>> getTable<T>(AppTables table);
}
