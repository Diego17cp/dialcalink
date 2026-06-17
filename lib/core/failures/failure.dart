sealed class Failure {
  const Failure(this.message, {this.cause});
  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.cause});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.cause});
}

class IntegrityFailure extends Failure {
  const IntegrityFailure(super.message, {super.cause});
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.cause});
}