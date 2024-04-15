extension ListHiCoreEx<E> on List<E> {
  E? get safeLast {
    if (isEmpty) {
      return null;
    }
    return last;
  }
}