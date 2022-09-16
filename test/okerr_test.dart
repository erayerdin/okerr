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
    test('ok toString', () {
      final value = Ok(0).toString();
      expect(value, equals('Result(value: 0)'));
    });

    test('err toString', () {
      final value = Err(0).toString();
      expect(value, equals('Result(error: 0)'));
    });
  });

  group('result methods', () {
    test('is ok and not err?', () {
      final result = Ok(0);
      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
    });

    test('is err and not ok?', () {
      final result = Err(0);
      expect(result.isErr, isTrue);
      expect(result.isOk, isFalse);
    });

    test('ok and not err', () {
      final result = Ok(0);
      expect(result.ok, equals(0));
      expect(result.err, isNull);
    });

    test('err and not ok', () {
      final result = Err(0);
      expect(result.err, equals(0));
      expect(result.ok, isNull);
    });

    group('map', () {
      test('if ok', () {
        final result1 = Ok(0);
        final result2 = result1.map((value) => value != 0);
        expect(result2.ok, isFalse);
      });

      test('if err', () {
        final result1 = Err(0);
        final result2 = result1.map((value) => value != 0);
        expect(result2.err, equals(0));
      });
    });

    group('map or', () {
      test('if ok', () {
        final value = Ok(0).mapOr(
          def: 1,
          // TODO find a workaround for dynamic target
          f: (value) => value - 1,
        );
        expect(value, equals(-1));
      });

      test('if err', () {
        final value = Err(0).mapOr(
          def: 1,
          // TODO find a workaround for dynamic target
          f: (value) => value - 1,
        );
        expect(value, equals(1));
      });
    });

    group('map or else', () {
      test('if ok', () {
        final value = Ok(0).mapOrElse(
          // TODO find a workaround for dynamic target
          def: (error) => error + 1,
          // TODO find a workaround for dynamic target
          f: (value) => value - 1,
        );
        expect(value, equals(-1));
      });

      test('if err', () {
        final value = Err(0).mapOrElse(
          // TODO find a workaround for dynamic target
          def: (error) => error + 1,
          // TODO find a workaround for dynamic target
          f: (value) => value - 1,
        );
        expect(value, equals(1));
      });
    });

    group('map err', () {
      test('if ok', () {
        // TODO find a workaround for dynamic target
        final result = Ok(0).mapErr((error) => error + 1);
        expect(result.ok, equals(0));
        expect(result.err, isNull);
      });

      test('if err', () {
        // TODO find a workaround for dynamic target
        final result = Err(0).mapErr((error) => error + 1);
        expect(result.err, equals(1));
        expect(result.ok, isNull);
      });
    });

    group('expect', () {
      test('if ok', () {
        expect(Ok(0).expect('custom message'), equals(0));
      });

      test('if err', () {
        expect(
          () => Err(0).expect('custom message'),
          throwsA(
            isA<ResultException>().having(
              (exc) => exc.cause,
              'exception has message',
              'custom message',
            ),
          ),
        );
      });
    });

    group('unwrap', () {
      test('if ok', () {
        expect(Ok(0).unwrap(), equals(0));
      });

      test('if err', () {
        expect(
          () => Err(0).unwrap(),
          throwsA(
            isA<ResultException>().having(
              (exc) => exc.cause,
              'exception has message',
              'Result was expected to be Ok but it is `Result(error: 0)`.',
            ),
          ),
        );
      });
    });
  });
}
