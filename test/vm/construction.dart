import 'dart:math' as math;
import 'package:fatint/fatint.dart';
import 'package:test/test.dart';

void main() {
  group('VM.Constructor', () {
    test('Default', () {
      expect(new BigInteger().value, null);
      expect(new BigInteger(0).value, 0);

      expect(new BigInteger(10).toString(), "10");

      expect(new BigInteger(math.pow(2, 64)).value.toString(),
          '18446744073709551616');
      expect(new BigInteger(math.pow(2, 64)).bitLength, 65);

      expect(new BigInteger(math.pow(2, 100)).value.toString(),
          '1267650600228229401496703205376');
      expect(new BigInteger(math.pow(2, 100)).bitLength, 101);

      expect(new BigInteger(-math.pow(2, 64)).value.toString(),
          '-18446744073709551616');
      expect(new BigInteger(-math.pow(2, 64)).bitLength, 64);

      expect(
          new BigInteger(
                  0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
              .toString(radix: 16),
          "fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    });

    test('fromNum', () {
      expect(new BigInteger.fromNum(0).value, 0);
      expect(new BigInteger.fromNum(25.0).value, 25);
      expect(new BigInteger.fromNum(2e64).toString(),
          '20000000000000000426408380189087937446025157425359298935486676992');
      expect(new BigInteger.fromNum(2e64).bitLength, 214);
      expect(new BigInteger.fromNum(-2e64).value.toString(),
          '-20000000000000000426408380189087937446025157425359298935486676992');
      expect(new BigInteger.fromNum(-2e64).bitLength, 214);
    });

    test('fromBytes', () {
      expect(new BigInteger.fromBytes([0x1]).toString(), '1');
      expect(new BigInteger.fromBytes([0x1, 0]).toString(radix: 16), '100');
      expect(
          new BigInteger.fromBytes([0xAA, 0, 0]).toString(radix: 16), 'aa0000');
      expect(new BigInteger.fromBytes([0xFF, 0, 0, 0]).toString(radix: 16),
          'ff000000');
    });

    test('fromString.hex', () {
      expect(new BigInteger.fromString('abcd1234', 16).toString(radix: 16),
          'abcd1234');
      expect(new BigInteger.fromString('beef', 16).toString(radix: 16), 'beef');
    });
  });
}
