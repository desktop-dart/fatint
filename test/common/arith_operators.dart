import 'dart:math' as math;
import 'package:fatint/fatint.dart';
import 'package:test/test.dart';

import '../fixtures/fixture.dart';

void main() {
  group('arithmetics', () {
    test('multiplication', () {
      expect((bigDec('25') * bigDec('25')).toString(), '625');
      expect((bigHex('abcd1234') * bigHex('beef')).toString(radix: 16),
          '802297f6968c');
    });

    test('rand.allOps1', () {
      for (int i = 0; i < 100; i++) {
        final rnd = new math.Random();
        BigInteger x = bigInt(rnd.nextInt(100000000));
        BigInteger y = bigInt(rnd.nextInt(100000000));
        BigInteger z = x / y;
        z = z * y;
        z = z + x.remainder(y);
        z = z - x;
        expect(z.toString(), '0');
      }
    });

    test('rand.allOps2', () {
      for (int i = 0; i < 100; i++) {
        final rnd = new math.Random();
        BigInteger x = bigInt(rnd.nextInt(100000000));
        BigInteger y = bigInt(rnd.nextInt(100000000));
        DivResult divRes = x.divide(y);
        BigInteger z = divRes.q * y;
        z = z + divRes.r;
        z = z - x;
        expect(z.toString(), '0');
      }
    });

    test('rand.allOps3.bigValue', () {
      for (int i = 0; i < 100; i++) {
        final rnd = new math.Random();
        BigInteger x = bigHex(largeNum1Base16);
        BigInteger y = bigHex(
            "${largeNum1Base16}${rnd.nextInt(100000000).toRadixString(16)}");
        DivResult divRes = x.divide(y);
        BigInteger z = divRes.q * y;
        z += divRes.r;
        z -= x;
        expect(z.toString(), '0');
      }
    });

    test('rand.divide', () {
      DivResult divRes = bigInt(10).divide(bigInt(3));
      expect(divRes.q.toString(), '3');
      expect(divRes.r.toString(), '1');
      divRes = bigInt(400).divide(bigInt(11));
      expect(divRes.q.toString(), '36');
      expect(divRes.r.toString(), '4');
    });

    test('rand.allOps4.bigValue', () {
      BigInteger a = bigInt(5);
      BigInteger b = bigInt(20);

      BigInteger res = new BigInteger();
      res.assign = zero + a + b;

      expect(res.toString(), '25');
    });
  });
}
