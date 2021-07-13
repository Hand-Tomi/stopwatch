import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stopwatch/core/app_tables.dart';
import 'package:stopwatch/database/hive/table_imps.dart';
import 'package:stopwatch/model/config.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/model/lap.dart';

import '../database.dart';
import '../table.dart';

class DatabaseImps extends Database {
  final _isInitialized = BehaviorSubject<bool>.seeded(false);

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HistoryAdapter());
    Hive.registerAdapter(LapAdapter());
    Hive.registerAdapter(ConfigAdapter());
    _isInitialized.add(true);
  }

  @override
  Future<Table<T>> getTable<T>(AppTables table) async {
    await waitForInitalization();
    final box = await Hive.openBox<T>(table.name);
    return TableImpl<T>(box);
  }

  Future<void> waitForInitalization() async {
    await _isInitialized.firstWhere((isInitialized) => isInitialized);
  }
}
