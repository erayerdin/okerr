/// A custom exception for `Result` type.
/// Thrown with a custom message with [Result.expect] or
/// with a default message in `unwrap`.
class ResultException implements Exception {
  final String cause;

  ResultException(this.cause);
}
