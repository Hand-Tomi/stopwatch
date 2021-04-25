import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stopwatch/core/app_tables.dart';
import 'package:stopwatch/database/hive/table_imps.dart';
import 'package:stopwatch/database/model/history.dart';

import '../database.dart';
import '../table.dart';

class DatabaseImps extends Database {
  void init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HistoryAdapter());
  }

  Future<Table<T>> getTable<T>(AppTables table) async {
    return TableImpl(await Hive.openBox<T>(table.name)) as Table<T>;
  }
}
