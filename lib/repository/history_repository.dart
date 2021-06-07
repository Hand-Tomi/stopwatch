import 'package:stopwatch/core/app_tables.dart';
import 'package:stopwatch/database/database.dart';
import 'package:stopwatch/database/table.dart';
import 'package:stopwatch/model/history.dart';

class HistoryRepository {
  final Database _database;

  Table<History>? _table;

  HistoryRepository(this._database);

  // TODO AppTables을 의존하고 있는 곳이 있다.
  Future<Table<History>> getTable() async {
    if (_table == null) {
      final table = await _database.getTable<History>(AppTables.history);
      _table = table;
    }
    return await _database.getTable<History>(AppTables.history);
  }

  Future<Iterable<History>> getHistorys() async {
    final _table = await getTable();
    return _table.getValues();
  }

  Future<void> putHistory(String key, History history) async {
    final table = await getTable();
    await table.put(key, history);
  }

  String createNextKey() {
    return _currentMsec().hashCode.toString();
  }

  History createHistory(int msec) {
    final now = DateTime.now();
    return History(msec, now);
  }

  int _currentMsec() => DateTime.now().millisecondsSinceEpoch;
}
