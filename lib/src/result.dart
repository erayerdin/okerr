/// A global shorthand for `Result.ok(value)`.
// ignore: non_constant_identifier_names
Result Ok<T>(T value) => Result.ok(value);

/// A global shorthand for `Result.err(error)`.
// ignore: non_constant_identifier_names
Result Err<E>(E error) => Result.err(error);

/// Result is a type that represents either success (Ok) or failure (Err).
class Result<T, E> {
  final T? value;
  final E? error;

  // ------------ //
  // Constructors //
  // ------------ //
  Result._internal({required this.value, required this.error});
  factory Result.ok(T value) => Result._internal(value: value, error: null);
  factory Result.err(E error) => Result._internal(value: null, error: error);

  Result<T, E> copyWith({
    T? value,
    E? error,
  }) {
    return Result<T, E>._internal(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }

  // ------------------ //
  // Data Class Methods //
  // ------------------ //
  @override
  String toString() {
    if (value != null) {
      return 'Result(value: $value)';
    } else {
      return 'Result(error: $error)';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result<T, E> &&
        other.value == value &&
        other.error == error;
  }

  @override
  int get hashCode => value.hashCode ^ error.hashCode;

  // -------------- //
  // Result Methods //
  // -------------- //

  /// Returns `true` if the result is `Ok`.
  bool get isOk => value != null && error == null;

  /// Returns `true` if the result is `Err`.
  bool get isErr => error != null && value == null;

  /// Converts from `Result<T, E> to `T?`.
  T? get ok => value;

  /// Converts from `Result<T, E> to `E?`.
  E? get err => error;
}
