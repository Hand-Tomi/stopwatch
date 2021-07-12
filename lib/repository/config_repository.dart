import 'package:stopwatch/core/app_tables.dart';
import 'package:stopwatch/database/database.dart';
import 'package:stopwatch/database/table.dart';
import 'package:stopwatch/model/config.dart';

class ConfigRepository {
  final Database _database;

  Table<Config>? _table;

  ConfigRepository(this._database);

  Future<Table<Config>> _getTable() async {
    if (_table == null) {
      final table = await _database.getTable<Config>(AppTables.config);
      _table = table;
    }
    return _table!;
  }
}
