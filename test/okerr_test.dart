import 'package:okerr/okerr.dart';
import 'package:test/test.dart';

void main() {
  // TODO write a test
  // group('A group of tests', () {
  //   final awesome = Awesome();

  //   setUp(() {
  //     // Additional setup goes here.
  //   });

  //   test('First Test', () {
  //     expect(awesome.isAwesome, isTrue);
  //   });
  // });

  group('construct', () {
    test('ok with factory constructor', () {
      Result.ok(0);
    });

    test('err with factory constructor', () {
      Result.err(0);
    });

    test('ok with global', () {
      Ok(0);
    });

    test('err with global', () {
      Err(0);
    });
  });

  group('data class features', () {
    test('ok toString', () async {
      final value = Ok(0).toString();
      expect(value, equals('Result(value: 0)'));
    });

    test('err toString', () {
      final value = Err(0).toString();
      expect(value, equals('Result(error: 0)'));
    });
  });

  group('result methods', () {
    test('is ok and not err?', () async {
      final result = Ok(0);
      expect(result.isOk, equals(true));
      expect(result.isErr, equals(false));
    });

    test('is err and not ok?', () {
      final result = Err(0);
      expect(result.isErr, equals(true));
      expect(result.isOk, equals(false));
    });
  });
}
