import 'package:okerr/okerr.dart';

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
  Result<U, E> map<U>(U Function(T value) op) {
    if (isErr) {
      return Result.err(_error as E);
    }

    return Result.ok(op(_value as T));
  }

  /// Returns the provided default (if `Err`), or applies a function to the contained value (if `Ok`).
  U mapOr<U>({
    // default is a reserved keyword, so i've used def instead
    required U def,
    required U Function(T value) f,
  }) {
    if (isErr) {
      return def;
    }

    return f(_value as T);
  }

  /// Maps a `Result<T, E>` to `U` by applying fallback function default to a contained `Err` value, or function `f` to a contained `Ok` value.
  U mapOrElse<U>({
    required U Function(E error) def,
    required U Function(T value) f,
  }) {
    if (isErr) {
      return def(_error as E);
    }

    return f(_value as T);
  }

  /// Maps a `Result<T, E>` to `Result<T, F>` by applying a function to a contained `Err` value, leaving an `Ok` value untouched.
  Result<T, F> mapErr<F>(F Function(E error) op) {
    if (isOk) {
      return Result.ok(_value as T);
    }

    return Result.err(op(_error as E));
  }

  /// Returns the contained `Ok` value. If self is `Err`, throws
  /// `ResultException` with the given message.
  T expect(String msg) {
    if (isErr) {
      throw ResultException(msg);
    }

    return _value as T;
  }

  /// Returns the contained `Ok` value. If self is `Err`, throws
  /// `ResultException`.
  T unwrap() => expect('Result was expected to be Ok but it is `$this`.');

  /// Returns the contained `Err` value. If self is `Ok`, throws
  /// `ResultException` with the given message.
  E expectErr(String msg) {
    if (isOk) {
      throw ResultException(msg);
    }

    return _error as E;
  }

  /// Returns the contained `Err` value. If self is `Ok`, throws
  /// `ResultException`.
  E unwrapErr() => expectErr(
        'Result was expected to be Err but it is `$this`.',
      );

  /// Returns `res` if the `result` is `Ok`, otherwise returns the `Err` value of `self`.
  Result<U, E> and<U>(Result<U, E> res) {
    if (isOk) {
      return res;
    }

    return this as Result<U, E>;
  }

  /// Calls `op` if the result is `Ok`, otherwise returns the `Err` value of `self`.
  Result<U, E> andThen<U>(Result<U, E> Function(T value) op) {
    if (isOk) {
      return op(_value as T);
    }

    return this as Result<U, E>;
  }

  Result<T, F> or<F>(Result<T, F> res) {
    if (isErr) {
      return res;
    }

    return this as Result<T, F>;
  }
}
