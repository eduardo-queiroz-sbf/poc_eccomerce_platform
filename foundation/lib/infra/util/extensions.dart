extension IndexedIterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    int i = 0;
    return map((E e) => f(e, i++));
  }
}

extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> sortBy<TSelected extends Comparable<TSelected>>(
    TSelected Function(T) selector,
  ) =>
      toList()..sort((T a, T b) => selector(a).compareTo(selector(b)));

  Iterable<T> sortByDescending<TSelected extends Comparable<TSelected>>(
    TSelected Function(T) selector,
  ) =>
      sortBy(selector).toList().reversed;
}
