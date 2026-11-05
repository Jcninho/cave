Stream<List<T>> mapStreamList<R, T>(
    Stream<List<R>> source,
    T Function(R row) mapper,
    ) {
  return source.map((rows) => rows.map(mapper).toList());
}
