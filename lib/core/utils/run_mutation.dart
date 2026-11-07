import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<Result<T, Failure>> runMutation<T>(
    Future<Result<T, Failure>> Function() action, AsyncValue<void> state
    ) async {
  state = const AsyncLoading<void>();

  try {
    final result = await action();
    state = const AsyncData<void>(null);
    return result;
  } catch (error, stackTrace) {
    state = AsyncError<void>(error, stackTrace);
    rethrow;
  }
}
