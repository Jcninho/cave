sealed class Result<T, E> {
  const Result();

  factory Result.success(T value) = Success<T, E>;
  factory Result.failure(E error) = Error<T, E>;

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Error<T, E>;

  T get success => (this as Success<T, E>).value;

  E get failure => (this as Error<T, E>).error;
}

final class Success<T, E> extends Result<T, E> {
  final T value;
  const Success(this.value);
}

final class Error<T, E> extends Result<T, E> {
  final E error;
  const Error(this.error);
}
