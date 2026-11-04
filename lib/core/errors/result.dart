
sealed class Result<T, E> {
  const Result();

  factory Result.left(T value) = Left<T, E>;
  factory Result.right(E error) = Right<T, E>;

  bool get isLeft => this is Left<T, E>;
  bool get isRight => this is Right<T, E>;

  T get left => (this as Left<T, E>).value;

  E get right => (this as Right<T, E>).error;
}

final class Left<T, E> extends Result<T, E> {
  final T value;
  const Left(this.value);
}

final class Right<T, E> extends Result<T, E> {
  final E error;
  const Right(this.error);
}
