enum AppTables { history, config }

extension AppTableName on AppTables {
  String get name {
    switch (this) {
      case AppTables.history:
        return 'history';
      case AppTables.config:
        return 'config';
    }
  }
}
