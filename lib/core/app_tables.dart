enum AppTables { history }

extension AppTableName on AppTables {
  String get name {
    switch (this) {
      case AppTables.history:
        return 'history';
    }
  }
}
