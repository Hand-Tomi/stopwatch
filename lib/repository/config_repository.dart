import 'package:stopwatch/core/app_tables.dart';
import 'package:stopwatch/database/database.dart';
import 'package:stopwatch/database/table.dart';
import 'package:stopwatch/model/config.dart';
import 'package:stopwatch/model/current_stopwatch.dart';

class ConfigRepository {
  final String configKey = 'configKey';
  final Database _database;

  Table<Config>? _table;

  ConfigRepository(this._database);

  Future<CurrentStopwatch?> getCurrentStopwatch() async {
    final config = await _getConfig();
    return config.currentStopwatch;
  }

  Future<void> putCurrentStopwatch(CurrentStopwatch currentStopwatch) async {
    final config = await _getConfig();
    final newConfig = config.copyWith(currentStopwatch: currentStopwatch);
    _putConfig(newConfig);
  }

  Future<void> removeTimeStarted() async {
    final config = await _getConfig();
    final newConfig = config.copyWith(currentStopwatch: null);
    _putConfig(newConfig);
  }

  Future<Table<Config>> _getTable() async {
    if (_table == null) {
      final table = await _database.getTable<Config>(AppTables.config);
      _table = table;
    }
    return _table!;
  }

  Future<Config> _getConfig() async {
    final table = await _getTable();
    final config = table.get(configKey);
    if (config == null) {
      final initalConfig = _createInitalConfig();
      _putConfig(initalConfig);
      return initalConfig;
    } else {
      return config;
    }
  }

  Future<void> _putConfig(Config config) async {
    final table = await _getTable();
    table.put(configKey, config);
  }

  Config _createInitalConfig() => Config(null);
}
