abstract interface class Failure {
  final String message;
  final StackTrace? stackTrace;

  const Failure(this.message, [this.stackTrace]);

  @override
  String toString() => message;
}

final class DataFailure extends Failure {
  const DataFailure(super.message, [super.stackTrace]);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.stackTrace]);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, [super.stackTrace]);
}

final class ConflictFailure extends Failure {
  const ConflictFailure(super.message, [super.stackTrace]);
}
