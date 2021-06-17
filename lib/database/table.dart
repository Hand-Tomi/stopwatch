abstract class Table<T> {
  Future<int> add(T value);
  Future<void> put(String key, T value);
  Iterable<T> getValues();
  Future<void> delete(dynamic key);
}
