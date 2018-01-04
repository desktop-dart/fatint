import 'dart:math' as math;
import 'package:fatint/fatint.dart';
import 'package:test/test.dart';

void main() {
  group('BitManipulation', () {
    test('SetBit', () {
      final five = new BigInteger()..assignInt = 5;
      expect(five.value, 5);
    });
  });
}
