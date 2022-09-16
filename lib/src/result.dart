/// A global shorthand for `Result.ok(value)`.
// ignore: non_constant_identifier_names
Result Ok<T>(T value) => Result.ok(value);

/// A global shorthand for `Result.err(error)`.
// ignore: non_constant_identifier_names
Result Err<E>(E error) => Result.err(error);

/// Result is a type that represents either success (Ok) or failure (Err).
class Result<T, E> {
  late T? _value;
  late E? _error;

  // ------------ //
  // Constructors //
  // ------------ //
  Result._internal({required T? value, required E? error}) {
    _value = value;
    _error = error;
  }
  factory Result.ok(T value) => Result._internal(value: value, error: null);
  factory Result.err(E error) => Result._internal(value: null, error: error);

  Result<T, E> copyWith({
    T? value,
    E? error,
  }) {
    return Result<T, E>._internal(
      value: value ?? _value,
      error: error ?? _error,
    );
  }

  // ------------------ //
  // Data Class Methods //
  // ------------------ //
  @override
  String toString() {
    if (_value != null) {
      return 'Result(value: $_value)';
    } else {
      return 'Result(error: $_error)';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result<T, E> && other.ok == _value && other.err == _error;
  }

  @override
  int get hashCode => _value.hashCode ^ _error.hashCode;

  // -------------- //
  // Result Methods //
  // -------------- //

  /// Returns `true` if the result is `Ok`.
  bool get isOk => _value != null && _error == null;

  /// Returns `true` if the result is `Err`.
  bool get isErr => _error != null && _value == null;

  /// Converts from `Result<T, E> to `T?`.
  T? get ok => _value;

  /// Converts from `Result<T, E> to `E?`.
  E? get err => _error;

  /// Maps a `Result<T, E>` to `Result<U, E>` by applying a function to a contained `Ok` value, leaving an `Err` value untouched.
  Result<U, E> map<U>(U Function(T) op) {
    if (_error != null) {
      return Result.err(_error as E);
    }

    return Result.ok(op(_value as T));
  }
}
