library dart.fatint;

import 'vm/vm.dart';

BigInt bigInt(int value) => new BigInt(value);

BigInt bigHex(String value) => new BigInt.fromString(value, 16);

BigInt bigDec(String value) => new BigInt.fromString(value);

/// Emulates signed and unsigned big integer on all supported platforms
abstract class BigInt implements Comparable<BigInt> {
  static BigInt get zero {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm(0);
    }
  }

  static BigInt get one {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm(1);
    }
  }

  /// Creates a [BigInt] with integer value [_value]
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerVM(5);
  factory BigInt([int v]) {
    // TODO if(v < Internal.minJsInt ||v > Internal.maxJsInt) throw new Exception();
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm(v);
    }
  }

  /// Creates a [BigInt] with integer value obtained by converting [data]
  /// to integer.
  ///
  /// Example:
  ///
  ///     final five = new BigInteger.fromNum(5.0);
  factory BigInt.fromNum(num data) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.fromNum(data);
    }
  }

  factory BigInt.from8(int a,
      [int b, int c, int d, int e, int f, int g, int h]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.from8(a, b, c, d, e, f, g, h);
    }
  }

  factory BigInt.from16(int a, [int b, int c, int d]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.from16(a, b, c, d);
    }
  }

  factory BigInt.from32(int a, [int b]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.from32(a, b);
    }
  }

  /// Creates a [BigInt] from [bytes]
  ///
  /// Example:
  ///
  ///     final five = new BigInteger.fromBytes([0x5]);
  factory BigInt.fromBytes(List<int> bytes) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.fromBytes(bytes);
    }
  }

  /// Creates a [BigInt] by parsing integer representation of [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigInteger.fromString('5');
  ///     final beef = new BigInteger.fromString('beef', 16);
  factory BigInt.fromString(String dataStr, [int radix]) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.fromString(dataStr, radix);
    }
  }

  factory BigInt.fromSignedBytes(int signum, List<int> magnitude) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntVm.fromSignedBytes(signum, magnitude);
    }
  }

  /// Returns new [BigInt] with same value as [this].
  BigInt get clone;

  /// Returns a [BigIntRef] of clone of [this].
  ///
  /// Example:
  ///     final other = new BigInteger(5);
  ///     final five = new BigInteger(20);
  ///     five.assign += other; // five.toString() == '25'
  BigInt get assign;

  /// Assigns value of [this] to the value of [other]
  ///
  /// Example:
  ///     final other = new BigInteger(5);
  ///     final five = new BigInteger();
  ///     five.assign = other;  // five.toString() = '5'
  set assign(BigInt other);

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
  BigInt operator +(BigInt other);

  /// Return [this] - [other]. Does not modify either [this] or [other]!
  BigInt operator -(BigInt other);

  /// Return [this] * [other]. Does not modify either [this] or [other]!
  BigInt operator *(BigInt other);

  /// Return [this] / [other]. Does not modify either [this] or [other]!
  BigInt operator /(BigInt other);

  /// Return [this] ~/ [other]. Does not modify either [this] or [other]!
  BigInt operator ~/(BigInt other);

  /// Return [this] % [other]. Does not modify either [this] or [other]!
  BigInt operator %(BigInt other);

  /// Return -[this]. Does not modify [this]!
  BigInt operator -();

  /// Returns [this] & [other].Does not modify either [this] or [other]!
  BigInt operator &(BigInt other);

  /// Returns [this] | [other].Does not modify either [this] or [other]!
  BigInt operator |(BigInt other);

  /// Returns [this] ^ [other].Does not modify either [this] or [other]!
  BigInt operator ^(BigInt other);

  /// Returns ~[this]. Does not modify [this]!
  BigInt operator ~();

  BigInt andNot(covariant BigInt other);

  /// Return positive integer if [this] > [other], negative integer if [this] < [other],
  /// 0 if equal.
  int compareTo(BigInt a);

  bool equals(BigInt other);

  bool operator <(BigInt other);

  bool operator <=(BigInt other);

  bool operator >(BigInt other);

  bool operator >=(BigInt other);

  bool operator ==(other);

  /// Returns value left shifted by [n] bits.  Does not modify
  /// [this]!
  BigInt operator <<(int n);

  /// Returns value right shifted by [n] bits.  Does not modify
  /// [this]!
  BigInt operator >>(int n);

  /// Returns absolute value
  BigInt abs();

  DivResult divide(BigInt denominator);

  /// Returns [this] % [denominator].
  BigInt remainder(BigInt denominator);

  /// Returns [this] ^ [e]
  BigInt pow(int e);

  /// Returns [this]^[e] % [m]
  BigInt modPow(BigInt e, BigInt m);

  /// Returns 1/[this] % m
  BigInt modInverse(m);

  BigInt min(BigInt other);

  BigInt max(BigInt other);

  /// Returns gcd([this], [other])
  ///
  /// (HAC 14.54)
  BigInt gcd(BigInt other);

  /// Returns [this] | (1 << [bitPos]). Does not modify [this].
  BigInt setBit(int bitPos);

  /// Returns [this] & ~(1 << [bitPos]). Does not modify [this].
  BigInt clearBit(int bitPos);

  /// Returns [this] ^ (1 << [bitPos]). Does not modify [this].
  BigInt toggleBit(int bitPos);

  /// Returns [this] % [n] when n < 2^26
  BigInt modInt(int n);

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigInt modPowInt(int e, BigInt m);

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
  BigInt q;

  /// Reminder component of divide operation.
  BigInt r;

  DivResult({BigInt q, BigInt r})
      : q = q ?? new BigInt(),
        r = r ?? new BigInt();
}

abstract class BigIntRef implements BigInt {
  factory BigIntRef() {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntRefVm(new BigIntVm(0));
    }
  }

  factory BigIntRef.origin(BigInt origin) {
    if (_Context.isJs) {
      throw _jsNotSupportedException;
    } else {
      return new BigIntRefVm(origin);
    }
  }
}

class EfficientBigMath {
  const EfficientBigMath._();

  BigIntRef operator +(BigInt other) => new BigIntRef() + other;

  static const EfficientBigMath zero = const EfficientBigMath._();
}

const EfficientBigMath zero = EfficientBigMath.zero;

final _jsNotSupportedException = new UnsupportedError('V8 not supported yet!');
