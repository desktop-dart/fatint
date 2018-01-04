library dart.fatint;

import 'vm/vm.dart';

BigInteger bigInt(int value) => new BigInteger(value);

BigInteger bigHex(String value) => new BigInteger.fromString(value, 16);

BigInteger bigDec(String value) => new BigInteger.fromString(value);

/// Emulates signed and unsigned big integer on all supported platforms
abstract class BigInteger implements Comparable<BigInteger> {
  static BigInteger get zero {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM(0);
    }
  }

  static BigInteger get one {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM(1);
    }
  }

  /// Creates a [BigInteger] with integer value [_value]
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerVM(5);
  factory BigInteger([int v]) {
    // TODO if(v < Internal.minJsInt ||v > Internal.maxJsInt) throw new Exception();
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM(v);
    }
  }

  /// Creates a [BigInteger] with integer value obtained by converting [data]
  /// to integer.
  ///
  /// Example:
  ///
  ///     final five = new BigInteger.fromNum(5.0);
  factory BigInteger.fromNum(num data) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.fromNum(data);
    }
  }

  factory BigInteger.from8(int a,
      [int b, int c, int d, int e, int f, int g, int h]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.from8(a, b, c, d, e, f, g, h);
    }
  }

  factory BigInteger.from16(int a, [int b, int c, int d]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.from16(a, b, c, d);
    }
  }

  factory BigInteger.from32(int a, [int b]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.from32(a, b);
    }
  }

  /// Creates a [BigInteger] from [bytes]
  ///
  /// Example:
  ///
  ///     final five = new BigInteger.fromBytes([0x5]);
  factory BigInteger.fromBytes(List<int> bytes) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.fromBytes(bytes);
    }
  }

  /// Creates a [BigInteger] by parsing integer representation of [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigInteger.fromString('5');
  ///     final beef = new BigInteger.fromString('beef', 16);
  factory BigInteger.fromString(String dataStr, [int radix]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.fromString(dataStr, radix);
    }
  }

  factory BigInteger.fromSignedBytes(int signum, List<int> magnitude) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerVM.fromSignedBytes(signum, magnitude);
    }
  }

  /// Returns new [BigInteger] with same value as [this].
  BigInteger get clone;

  /// Returns a [BigIntegerRef] of clone of [this].
  ///
  /// Example:
  ///     final other = new BigInteger(5);
  ///     final five = new BigInteger(20);
  ///     five.assign += other; // five.toString() == '25'
  BigInteger get assign;

  /// Assigns value of [this] to the value of [other]
  ///
  /// Example:
  ///     final other = new BigInteger(5);
  ///     final five = new BigInteger();
  ///     five.assign = other;  // five.toString() = '5'
  set assign(BigInteger other);

  /// Sets integer value to [value]
  ///
  /// Example:
  ///     final five = new BigInteger();
  ///     five.assignInt = 5;
  set assignInt(int value);

  set assignBin(String value);

  set assignOct(String value);

  set assignDec(String value);

  set assignHex(String value);

  set assignBytes(List<int> bytes);

  /// Parses the integer value from its string representation [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigInteger();
  ///     five.setString('5');
  ///     final beef = new BigInteger();
  ///     five.setString('beef', 16);
  void setString(String dataStr, [int radix = 10]);

  void setSignedBytes(List<int> bytes, [bool isSigned = false]);

  /// Return string representation with [radix].
  String toString({int radix = 10});

  List<int> get toBytes;

  /// Return [this] + [other]. Does not modify either [this] or [other]!
  BigInteger operator +(BigInteger other);

  /// Return [this] - [other]. Does not modify either [this] or [other]!
  BigInteger operator -(BigInteger other);

  /// Return [this] * [other]. Does not modify either [this] or [other]!
  BigInteger operator *(BigInteger other);

  /// Return [this] / [other]. Does not modify either [this] or [other]!
  BigInteger operator /(BigInteger other);

  /// Return [this] ~/ [other]. Does not modify either [this] or [other]!
  BigInteger operator ~/(BigInteger other);

  /// Return [this] % [other]. Does not modify either [this] or [other]!
  BigInteger operator %(BigInteger other);

  /// Return -[this]. Does not modify [this]!
  BigInteger operator -();

  /// Returns [this] & [other].Does not modify either [this] or [other]!
  BigInteger operator &(BigInteger other);

  /// Returns [this] | [other].Does not modify either [this] or [other]!
  BigInteger operator |(BigInteger other);

  /// Returns [this] ^ [other].Does not modify either [this] or [other]!
  BigInteger operator ^(BigInteger other);

  /// Returns ~[this]. Does not modify [this]!
  BigInteger operator ~();

  BigInteger andNot(covariant BigInteger other);

  /// Return positive integer if [this] > [other], negative integer if [this] < [other],
  /// 0 if equal.
  int compareTo(BigInteger a);

  bool equals(BigInteger other);

  bool operator <(BigInteger other);

  bool operator <=(BigInteger other);

  bool operator >(BigInteger other);

  bool operator >=(BigInteger other);

  bool operator ==(other);

  /// Returns value left shifted by [n] bits.  Does not modify
  /// [this]!
  BigInteger operator <<(int n);

  /// Returns value right shifted by [n] bits.  Does not modify
  /// [this]!
  BigInteger operator >>(int n);

  /// Returns absolute value
  BigInteger abs();

  DivResult divide(BigInteger denominator);

  /// Returns [this] % [denominator].
  BigInteger remainder(BigInteger denominator);

  /// Returns [this] ^ [e]
  BigInteger pow(int e);

  /// Returns [this]^[e] % [m]
  BigInteger modPow(BigInteger e, BigInteger m);

  /// Returns 1/[this] % m
  BigInteger modInverse(m);

  BigInteger min(BigInteger other);

  BigInteger max(BigInteger other);

  /// Returns gcd([this], [other])
  ///
  /// (HAC 14.54)
  BigInteger gcd(BigInteger other);

  /// Returns [this] | (1 << [bitPos]). Does not modify [this].
  BigInteger setBit(int bitPos);

  /// Returns [this] & ~(1 << [bitPos]). Does not modify [this].
  BigInteger clearBit(int bitPos);

  /// Returns [this] ^ (1 << [bitPos]). Does not modify [this].
  BigInteger toggleBit(int bitPos);

  /// Returns [this] % [n] when n < 2^26
  BigIntegerVM modInt(int n);

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigInteger modPowInt(int e, BigInteger m);

  /// Returns true if value is even
  bool get isEven;

  /// Returns true if value is odd
  bool get isOdd;

  /// Returns number of bits required to represent [this].
  int get bitLength;

  /// Returns number of bytes required to represent [this].
  int get byteLength;

  /// Returns value as [int].
  int get value;

  /// Returns value as 8-bit integer.
  int get value8;

  /// Returns value as 16-bit integer.
  int get value16;

  /// Returns value as 32-bit integer.
  int get value32;

  /// Returns value as 32-bit integer.
  int get value53;

  /// Returns true iff bit at position [bitPos] is set.
  bool testBit(int bitPos);

  int get sign;

  bool get isNegative;

  // TODO add toUnsigned

  // TODO add toSigned

  // TODO add clamp
}

class _Context {
  static bool _isJs;

  static bool get isJs {
    if (_isJs != null) return _isJs;

    if (0.0 is int) {
      _isJs = true;
      return _isJs;
    }

    try {
      // make sure the sdk support modInverse
      _isJs = 3.modInverse(7) == -1;
      return _isJs;
    } catch (err) {
      _isJs = true;
      return _isJs;
    }
  }
}

class DivResult {
  /// Quotient component of divide operation.
  BigInteger q;

  /// Reminder component of divide operation.
  BigInteger r;

  DivResult({BigInteger q, BigInteger r})
      : q = q ?? new BigInteger(),
        r = r ?? new BigInteger();
}

abstract class BigIntegerRef implements BigInteger {
  factory BigIntegerRef() {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerRefVM(new BigIntegerVM(0));
    }
  }

  factory BigIntegerRef.origin(BigInteger origin) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntegerRefVM(origin);
    }
  }
}

class EfficientBigMath {
  const EfficientBigMath._();

  BigIntegerRef operator +(BigInteger other) => new BigIntegerRef() + other;

  static const EfficientBigMath zero = const EfficientBigMath._();
}

const EfficientBigMath zero = EfficientBigMath.zero;

final _jsNotSupportedException = new UnsupportedError('V8 not supported yet!');
