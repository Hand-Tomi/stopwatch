abstract class Table<T> {
  Future<int> add(T value);
  Iterable<T> getValues();
}
