import 'package:stopwatch/core/app_tables.dart';
import 'package:stopwatch/database/database.dart';
import 'package:stopwatch/database/table.dart';
import 'package:stopwatch/model/history.dart';
import 'package:stopwatch/model/lap.dart';

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
    return _table!;
  }

  Future<Iterable<History>> getHistorys() async {
    final _table = await getTable();
    return _table.getValues();
  }

  Future<History?> getHistory(dynamic key) async {
    final table = await getTable();
    return table.get(key);
  }

  Future<void> deleteHistory(dynamic key) async {
    final table = await getTable();
    table.delete(key);
  }

  String? _currentKey;

  bool isCurrentHistory() {
    return _currentKey == null;
  }

  void renewCurrentHistory() {
    _currentKey = _createNextKey();
    _putHistory(_currentKey!, _createNewHistory());
  }

  void clearCurrentHistory() {
    _currentKey = null;
  }

  Future<void> overwriteLapsInCurrentHistory(List<Lap> laps) async {
    final history = await _getCurrentHistory();
    if (history == null) throw NullThrownError();
    final newHistory = history.copyWith(laps: laps);
    _putHistory(_currentKey!, newHistory);
  }

  Future<void> overwriteTimesInCurrentHistory(int msec) async {
    final history = await _getCurrentHistory();
    if (history == null) throw NullThrownError();
    final newHistory = history.copyWith(msec: msec);
    _putHistory(_currentKey!, newHistory);
  }

  Future<void> _putHistory(String key, History history) async {
    final table = await getTable();
    await table.put(key, history);
  }

  String _createNextKey() {
    return _currentMsec().hashCode.toString();
  }

  History _createNewHistory() {
    final now = DateTime.now();
    return History(0, now);
  }

  Future<History?> _getCurrentHistory() async {
    if (_currentKey == null) throw NullThrownError();
    return getHistory(_currentKey);
  }

  int _currentMsec() => DateTime.now().millisecondsSinceEpoch;
}
