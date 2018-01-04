library fatint.dartvm;

import 'dart:typed_data';
import 'package:biginteger_js/biginteger_js.dart';

import '../bignum.dart';

/// Emulates signed and unsigned big integer on platforms where [int]
/// supports big int.
class BigIntJs implements BigInt {
  static BigIntJs get zero => new BigIntJs(0);

  static BigIntJs get one => new BigIntJs(1);

  /// The actual value
  BigInteger _value;

  BigIntJs._(BigInteger data) : _value = MakeBigInt.fromAnother(data);

  /// Creates a [BigIntJs] with integer value [value]
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerJs(5);
  BigIntJs([int value = 0]) : _value = MakeBigInt.fromNum(value);

  /// Creates a [BigIntJs] with integer value obtained by converting [data]
  /// to integer.
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerJs.fromNum(5.0);
  BigIntJs.fromNum(num data) : _value = MakeBigInt.fromNum(data.toInt());

  BigIntJs.from8(int a, [int b, int c, int d, int e, int f, int g, int h]) {
    final data = new List<int>();
    data.add(a & 0xFF);

    for (int v in <int>[b, c, d, e, f, g, h]) {
      if (v == null) break;

      data.add(v & 0xFF);
    }
    _value = MakeBigInt.fromBytes(data);
  }

  BigIntJs.from16(int a, [int b, int c, int d]) {
    final data = new List<int>();
    data.add((a >> 8) & 0xFF);
    data.add(a & 0xFF);

    for (int v in <int>[b, c, d]) {
      if (v == null) break;

      data.add((v >> 8) & 0xFF);
      data.add(v & 0xFF);
    }
    _value = MakeBigInt.fromBytes(data);
  }

  BigIntJs.from32(int a, [int b]) {
    _value = MakeBigInt.fromNum(a & 0xFFFFFFFF);
    if (b != null) {
      _value.shiftLeft(32).or(b & 0xFFFFFFFF);
    }
  }

  /// Creates a [BigIntJs] from [bytes]
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerJs.fromBytes([0x5]);
  BigIntJs.fromBytes(List<int> bytes) {
    assignBytes = bytes;
  }

  /// Creates a [BigIntJs] by parsing integer representation of [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigIntegerJs.fromString('5');
  ///     final beef = new BigIntegerJs.fromString('beef', 16);
  BigIntJs.fromString(String dataStr, [int radix]) {
    setString(dataStr, radix);
  }

  /// Creates a [BigIntJs] from [signum] and [bytes].
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerJs.fromSignedBytes(-1, [0x5]);
  factory BigIntJs.fromSignedBytes(int signum, List<int> magnitude) {
    if (signum == 0) return new BigIntJs.fromBytes(magnitude);

    final self = new BigIntJs();
    self.setSignedBytes(magnitude, true);

    if (signum < 0) {
      self._value = -self._value;
    }

    return self;
  }

  /// Returns new [BigInt] with same value as [this].
  BigIntJs get clone => new BigIntJs._(this._value);

  /// Returns a [BigIntRef] of clone of [this].
  ///
  /// Example:
  ///     final other = new BigIntegerJs(5);
  ///     final five = new BigIntegerJs(20);
  ///     five.assign += other; // five.toString() == '25'
  BigIntJs get assign => null; // TODO

  /// Assigns value of [this] to the value of [other]
  ///
  /// Example:
  ///     final other = new BigIntegerJs(5);
  ///     final five = new BigIntegerJs();
  ///     five.assign = other;  // five.toString() = '5'
  set assign(covariant BigIntJs other) => _value = other._value;

  /// Sets integer value to [value]
  ///
  /// Example:
  ///     final five = new BigIntegerJs();
  ///     five.assignInt = 5;
  set assignInt(int v) => _value = MakeBigInt.fromNum(v);

  set assignBin(String v) => _value = MakeBigInt.fromString(v, 2);

  set assignOct(String v) => _value = MakeBigInt.fromString(v, 8);

  set assignDec(String v) => _value = MakeBigInt.fromString(v, 10);

  set assignHex(String v) => _value = MakeBigInt.fromString(v, 16);

  set assignBytes(List<int> bytes) {
    _value = MakeBigInt.fromBytes(bytes);
  }

  /// Parses the integer value from its string representation [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigIntegerJs();
  ///     five.setString('5');
  ///     final beef = new BigIntegerJs();
  ///     five.setString('beef', 16);
  void setString(String dataStr, [int radix]) {
    _value = MakeBigInt.fromString(dataStr, radix);
  }

  void setSignedBytes(List<int> bytes, [bool isSigned = false]) {
    if (bytes.length == 0) {
      _value = 0;
      return;
    }

    bool neg = false;
    if (isSigned && (bytes[0] & 0xFF) > 0x7F) {
      neg = true;
    }

    if (neg) {
      int v = 0;
      for (int byte in bytes) {
        v = (v << 8) | (~((byte & 0xFF) - 256));
      }
      _value = ~v;
    } else {
      int v = 0;
      for (int byte in bytes) {
        v = (v << 8) | (byte & 0xFF);
      }
      _value = v;
    }
  }

  /// Return string representation with [radix].
  String toString({int radix = 10}) {
    return _value.toString(radix);
  }

  List<int> get toBytes {
    // TODO
    throw new UnimplementedError();
  }

  /// Return [this] + [other]. Does not modify either [this] or [other]!
  BigIntJs operator +(covariant BigIntJs other) =>
      new BigIntJs._(_value.add(other._value));

  /// Return [this] - [other]. Does not modify either [this] or [other]!
  BigIntJs operator -(covariant BigIntJs other) =>
      new BigIntJs._(_value.subtract(other._value));

  /// Return [this] * [other]. Does not modify either [this] or [other]!
  BigIntJs operator *(covariant BigIntJs other) =>
      new BigIntJs._(_value.multiply(other._value));

  /// Return [this] / [other]. Does not modify either [this] or [other]!
  BigIntJs operator /(covariant BigIntJs other) =>
      new BigIntJs._(_value.divide(other._value));

  /// Return [this] ~/ [other]. Does not modify either [this] or [other]!
  BigIntJs operator ~/(covariant BigIntJs other) =>
      new BigIntJs._(_value.divide(other._value));

  /// Return [this] % [other]. Does not modify either [this] or [other]!
  BigIntJs operator %(covariant BigIntJs other) =>
      new BigIntJs._(_value.mod(other._value));

  /// Return -[this]. Does not modify [this]!
  BigIntJs operator -() => new BigIntJs._(_value.negate());

  /// Returns [this] & [other].Does not modify either [this] or [other]!
  BigIntJs operator &(covariant BigIntJs other) =>
      new BigIntJs._(_value.and(other._value));

  /// Returns [this] | [other].Does not modify either [this] or [other]!
  BigIntJs operator |(covariant BigIntJs other) =>
      new BigIntJs._(_value.or(other._value));

  /// Returns [this] ^ [other].Does not modify either [this] or [other]!
  BigIntJs operator ^(covariant BigIntJs other) =>
      new BigIntJs._(_value.xor(other._value));

  /// Returns ~[this].Does not modify [this]!
  BigIntJs operator ~() => new BigIntJs._(_value.not());

  BigIntJs andNot(covariant BigIntJs other) =>
      new BigIntJs._(_value.and(other._value.not()));

  /// Return positive integer if [this] > [other], negative integer if [this] < [other],
  /// 0 if equal.
  int compareTo(covariant BigIntJs other) => _value.compareTo(other._value);

  bool equals(covariant BigIntJs other) =>
      this.compareTo(other) == 0 ? true : false;

  bool operator <(covariant BigIntJs other) =>
      compareTo(other) < 0 ? true : false;

  bool operator <=(covariant BigIntJs other) =>
      compareTo(other) <= 0 ? true : false;

  bool operator >(covariant BigIntJs other) =>
      compareTo(other) > 0 ? true : false;

  bool operator >=(covariant BigIntJs other) =>
      compareTo(other) >= 0 ? true : false;

  bool operator ==(other) {
    if (other is! BigIntJs) return false;
    return compareTo(other) == 0 ? true : false;
  }

  /// Returns value left shifted by [n] bits.  Does not modify
  /// [this]!
  BigIntJs operator <<(int n) => new BigIntJs._(_value.shiftLeft(n));

  /// Returns value right shifted by [n] bits.  Does not modify
  /// [this]!
  BigIntJs operator >>(int n) => new BigIntJs._(_value.shiftRight(n));

  /// Returns absolute value
  BigIntJs abs() => new BigIntJs._(_value.abs());

  DivResult divide(BigInt denominator) {
    return new DivResult(q: this / denominator, r: remainder(denominator));
  }

  /// Returns [this] % [denominator].
  BigIntJs remainder(covariant BigIntJs denominator) =>
      new BigIntJs._(_value.remainder(denominator._value));

  /// Returns [this] ^ [e]
  BigIntJs pow(int e) {
    if (e > 0xffffffff || e < 1) return BigIntJs.one;
    return new BigIntJs._(_value.pow(e));
  }

  /// Returns [this]^[e] % [m]
  ///
  /// (HAC 14.85)
  BigIntJs modPow(covariant BigIntJs e, covariant BigIntJs m) =>
      new BigIntJs._(_value.modPow(e._value, m._value));

  /// Returns 1/[this] % m
  ///
  /// (HAC 14.61)
  BigIntJs modInverse(covariant BigIntJs m) =>
      new BigIntJs._(_value.modInv(m._value));

  BigIntJs min(covariant BigIntJs a) => (this.compareTo(a) < 0) ? this : a;

  BigIntJs max(covariant BigIntJs a) => (this.compareTo(a) > 0) ? this : a;

  /// Returns gcd([this], [other])
  ///
  /// (HAC 14.54)
  BigIntJs gcd(covariant BigIntJs other) =>
      new BigIntJs._(MakeBigInt.gcd(_value, other._value));

  /// Returns [this] | (1 << [bitPos]). Does not modify [this].
  BigIntJs setBit(int bitPos) =>
      new BigIntJs._(_value.or(MakeBigInt.one.shiftLeft(bitPos)));

  /// Returns [this] & ~(1 << [bitPos]). Does not modify [this].
  BigIntJs clearBit(int bitPos) =>
      new BigIntJs._(_value.and(MakeBigInt.one.shiftLeft(bitPos).not()));

  /// Returns [this] ^ (1 << [bitPos]). Does not modify [this].
  BigIntJs toggleBit(int bitPos) =>
      new BigIntJs._(_value.xor(MakeBigInt.one.shiftLeft(bitPos)));

  /// Returns [this] % [n] when n < 2^26
  BigIntJs modInt(int n) => new BigIntJs._(_value.mod(n));

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigIntJs modPowInt(int e, covariant BigIntJs m) =>
      new BigIntJs._(_value.modPow(e, m._value));

  /// Returns true if value is even
  bool get isEven => _value.isEven();

  /// Returns true if value is odd
  bool get isOdd => _value.isOdd();

  /// Returns number of bits required to represent [this].
  int get bitLength {
    // TODO
    throw new UnimplementedError();
  }

  /// Returns number of bytes required to represent [this].
  int get byteLength => (bitLength + 7) ~/ 8;

  /// Returns value as [int].
  int get value => _value.toJSNumber();

  /// Returns value as 8-bit integer.
  int get value8 => value & 0xff;

  /// Returns value as 16-bit integer.
  int get value16 => value & 0xffff;

  /// Returns value as 32-bit integer.
  int get value32 => value & 0xffffffff;

  /// Returns value as 53-bit integer.
  int get value53 => value & 0x1fffffffffffff;

  /// Returns true iff bit at position [bitPos] is set.
  bool testBit(int bitPos) =>
      !_value.and(MakeBigInt.one.shiftLeft(bitPos)).isZero();

  int get sign => _value.isZero() ? 0 : _value.isNegative() ? -1 : 1;

  bool get isNegative => _value.isNegative();
}
