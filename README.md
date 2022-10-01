# okerr

[![Pub Version](https://img.shields.io/pub/v/okerr?label=version&logo=dart&style=flat-square)](https://pub.dev/packages/okerr)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/erayerdin/okerr/Dart?logo=github&style=flat-square)

Okerr is a Dart package for [Result type of Rust](https://doc.rust-lang.org/std/result/enum.Result.html).

## Methods

The majority of methods in [std::result::Result of Rust](https://doc.rust-lang.org/std/result/enum.Result.html) has been implemented. The criteria for implementation are:

 - The method is not in the nightly-only experimental API. For example, [is_ok_and](https://doc.rust-lang.org/std/result/enum.Result.html#method.is_ok_and) is not implemented in this package.
 - The methods that deal with ownership and borrowing do not make sense in the context of Dart. Thus, `as_mut`, `as_deref`, `as_deref_mut`, etc. are not implemented.
 - The methods that deal with iteration are not implemented such as `iter` and `iter_mut`.
 - Unsafe methods are not implemented.

An extra `match` method is implemented to mimic the pattern matching with `Result`s in Rust.

Check [the API documentation](https://pub.dev/documentation/okerr/latest/) in order to see all the implemented methods.

### Extra Method: `match`

`match` is a method that mimics the pattern matching with `Result`s in Rust. See the example:

```dart
final result1 = Ok(0);
final value1 = result1.match(
    ok: (value) => value == 0,
    err: (error) => false,
); // value1 is `true`

final result2 = Err(0);
final value2 = result2.match(
    ok: (value) => value == 0,
    err: (error) => false,
); // value2 is `false`
```

## Mentions

[result](https://pub.dev/packages/result) package is another one targeting the same thing, but it's not been updated for years now whereas Dart has changed a lot. It can be error-prone to use.

[dartz](https://pub.dev/packages/dartz) is another alternative. It is essentially a functional programming library and comes with many things such as immutable persistent collections, type class instances etc. Its [Either](https://pub.dev/documentation/dartz/latest/dartz/Either-class.html) class holds similarity to `Result`.