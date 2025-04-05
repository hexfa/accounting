extension UniqueList<T> on List<T> {
  List<T> get unique => toSet().toList();
}
