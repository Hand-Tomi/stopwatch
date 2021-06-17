import 'package:hive/hive.dart';

import '../table.dart';

class TableImpl<T> extends Table<T> {
  Box<T> box;
  TableImpl(this.box);

  @override
  Future<int> add(value) => box.add(value);

  @override
  Future<void> put(key, value) => box.put(key, value);

  @override
  Future<void> delete(key) => box.delete(key);

  @override
  Iterable<T> getValues() => box.values;
}
