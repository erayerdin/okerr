// ignore: non_constant_identifier_names
Result Ok<T>(T value) => Result.ok(value);

// ignore: non_constant_identifier_names
Result Err<E>(E error) => Result.err(error);

class Result<T, E> {
  final T? value;
  final E? error;

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
}
