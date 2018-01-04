import 'dart:math' as math;
import 'package:fatint/fatint.dart';
import 'package:test/test.dart';

void main() {
  group('math', () {
    test('mod', () {
      expect((bigInt(25) % bigInt(7)).toString(), '4');
      expect((bigHex('abcd1234') % bigHex('beef')).toString(radix: 16), 'b60c');
    });

    test('pow', () {
      expect((bigInt(3).pow(3)).toString(radix: 16), '1b');
    });
  });
}
