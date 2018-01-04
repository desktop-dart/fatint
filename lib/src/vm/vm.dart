library fatint.dartvm;

import 'dart:math' as math;
import 'dart:typed_data';

import '../bignum.dart';

part 'ref.dart';

/// Emulates signed and unsigned big integer on platforms where [int]
/// supports big int.
class BigIntVm implements BigInt {
  static BigIntVm get zero => new BigIntVm(0);

  static BigIntVm get one => new BigIntVm(1);

  /// The actual value
  int _value;

  /// Creates a [BigIntVm] with integer value [_value]
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerVM(5);
  BigIntVm([this._value = 0]);

  /// Creates a [BigIntVm] with integer value obtained by converting [data]
  /// to integer.
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerVM.fromNum(5.0);
  BigIntVm.fromNum(num data) : _value = data.toInt();

  BigIntVm.from8(int a, [int b, int c, int d, int e, int f, int g, int h]) {
    _value = a & 0xFF;

    for (int v in <int>[b, c, d, e, f, g, h]) {
      if (v == null) break;

      _value = (_value << 8) | (v & 0xFF);
    }
  }

  BigIntVm.from16(int a, [int b, int c, int d]) {
    _value = a & 0xFFFF;

    for (int v in <int>[b, c, d]) {
      if (v == null) break;

      _value = (_value << 16) | (v & 0xFFFF);
    }
  }

  BigIntVm.from32(int a, [int b]) {
    _value = a & 0xFFFFFFFF;
    if (b != null) _value = (_value << 32) | (b & 0xFFFFFFFF);
  }

  /// Creates a [BigIntVm] from [bytes]
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerVM.fromBytes([0x5]);
  BigIntVm.fromBytes(List<int> bytes) {
    assignBytes = bytes;
  }

  /// Creates a [BigIntVm] by parsing integer representation of [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigIntegerVM.fromString('5');
  ///     final beef = new BigIntegerVM.fromString('beef', 16);
  BigIntVm.fromString(String dataStr, [int radix]) {
    setString(dataStr, radix);
  }

  /// Creates a [BigIntVm] from [signum] and [bytes].
  ///
  /// Example:
  ///
  ///     final five = new BigIntegerVM.fromSignedBytes(-1, [0x5]);
  factory BigIntVm.fromSignedBytes(int signum, List<int> magnitude) {
    if (signum == 0) return new BigIntVm.fromBytes(magnitude);

    final self = new BigIntVm();
    self.setSignedBytes(magnitude, true);

    if (signum < 0) {
      self._value = -self._value;
    }

    return self;
  }

  /// Returns new [BigInt] with same value as [this].
  BigIntVm get clone => new BigIntVm(this._value);

  /// Returns a [BigIntRef] of clone of [this].
  ///
  /// Example:
  ///     final other = new BigIntegerVM(5);
  ///     final five = new BigIntegerVM(20);
  ///     five.assign += other; // five.toString() == '25'
  BigIntVm get assign => new BigIntRefVm(clone);

  /// Assigns value of [this] to the value of [other]
  ///
  /// Example:
  ///     final other = new BigIntegerVM(5);
  ///     final five = new BigIntegerVM();
  ///     five.assign = other;  // five.toString() = '5'
  set assign(covariant BigIntVm other) => _value = other._value;

  /// Sets integer value to [value]
  ///
  /// Example:
  ///     final five = new BigIntegerVM();
  ///     five.assignInt = 5;
  set assignInt(int v) => _value = v;

  set assignBin(String v) => _value = int.parse(v, radix: 2, onError: (_) => 0);

  set assignOct(String v) => _value = int.parse(v, radix: 8, onError: (_) => 0);

  set assignDec(String v) =>
      _value = int.parse(v, radix: 10, onError: (_) => 0);

  set assignHex(String v) =>
      _value = int.parse(v, radix: 16, onError: (_) => 0);

  set assignBytes(List<int> bytes) {
    _value = 0;

    for (int v in bytes ?? <int>[]) {
      _value = (_value << 8) | (v & 0xFF);
    }
  }

  /// Parses the integer value from its string representation [dataStr].
  ///
  /// [radix] can be used to parse integers encoded with radix other
  /// than 10. [radix] defaults to 10.
  ///
  /// Example:
  ///     final five = new BigIntegerVM();
  ///     five.setString('5');
  ///     final beef = new BigIntegerVM();
  ///     five.setString('beef', 16);
  void setString(String dataStr, [int radix]) {
    _value = int.parse(dataStr, radix: radix, onError: (_) => 0);
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
    return _value.toRadixString(radix);
  }

  List<int> get toBytes {
    final ret = new Uint8List(byteLength);

    for (int i = 0; i < ret.length; i++) {
      ret[i] = (_value >> ((ret.length - i - 1) * 8)) & 0xFF;
    }

    return ret;
  }

  /// Return [this] + [other]. Does not modify either [this] or [other]!
  BigIntVm operator +(covariant BigIntVm other) =>
      new BigIntVm(_value + other._value);

  /// Return [this] - [other]. Does not modify either [this] or [other]!
  BigIntVm operator -(covariant BigIntVm other) =>
      new BigIntVm(_value - other._value);

  /// Return [this] * [other]. Does not modify either [this] or [other]!
  BigIntVm operator *(covariant BigIntVm other) =>
      new BigIntVm(_value * other._value);

  /// Return [this] / [other]. Does not modify either [this] or [other]!
  BigIntVm operator /(covariant BigIntVm other) =>
      new BigIntVm(_value ~/ other._value);

  /// Return [this] ~/ [other]. Does not modify either [this] or [other]!
  BigIntVm operator ~/(covariant BigIntVm other) =>
      new BigIntVm(_value ~/ other._value);

  /// Return [this] % [other]. Does not modify either [this] or [other]!
  BigIntVm operator %(covariant BigIntVm other) =>
      new BigIntVm(_value % other._value);

  /// Return -[this]. Does not modify [this]!
  BigIntVm operator -() => new BigIntVm(-_value);

  /// Returns [this] & [other].Does not modify either [this] or [other]!
  BigIntVm operator &(covariant BigIntVm other) =>
      new BigIntVm(_value & other._value);

  /// Returns [this] | [other].Does not modify either [this] or [other]!
  BigIntVm operator |(covariant BigIntVm other) =>
      new BigIntVm(_value | other._value);

  /// Returns [this] ^ [other].Does not modify either [this] or [other]!
  BigIntVm operator ^(covariant BigIntVm other) =>
      new BigIntVm(_value ^ other._value);

  /// Returns ~[this].Does not modify [this]!
  BigIntVm operator ~() => new BigIntVm(~_value);

  BigIntVm andNot(covariant BigIntVm other) =>
      new BigIntVm(_value & ~other._value);

  /// Return positive integer if [this] > [other], negative integer if [this] < [other],
  /// 0 if equal.
  int compareTo(covariant BigIntVm other) => _value.compareTo(other._value);

  bool equals(covariant BigIntVm other) =>
      this.compareTo(other) == 0 ? true : false;

  bool operator <(covariant BigIntVm other) =>
      compareTo(other) < 0 ? true : false;

  bool operator <=(covariant BigIntVm other) =>
      compareTo(other) <= 0 ? true : false;

  bool operator >(covariant BigIntVm other) =>
      compareTo(other) > 0 ? true : false;

  bool operator >=(covariant BigIntVm other) =>
      compareTo(other) >= 0 ? true : false;

  bool operator ==(other) {
    if (other is! BigIntVm) return false;
    return compareTo(other) == 0 ? true : false;
  }

  /// Returns value left shifted by [n] bits.  Does not modify
  /// [this]!
  BigIntVm operator <<(int n) => new BigIntVm(_value << n);

  /// Returns value right shifted by [n] bits.  Does not modify
  /// [this]!
  BigIntVm operator >>(int n) => new BigIntVm(_value >> n);

  /// Returns absolute value
  BigIntVm abs() => new BigIntVm(_value.abs());

  DivResult divide(BigInt denominator) {
    return new DivResult(q: this / denominator, r: remainder(denominator));
  }

  /// Returns [this] % [denominator].
  BigIntVm remainder(covariant BigIntVm denominator) =>
      new BigIntVm(_value.remainder(denominator._value));

  /// Returns [this] ^ [e]
  BigIntVm pow(int e) {
    if (e > 0xffffffff || e < 1) return BigIntVm.one;
    return new BigIntVm(math.pow(_value, e));
  }

  /// Returns [this]^[e] % [m]
  ///
  /// (HAC 14.85)
  BigIntVm modPow(covariant BigIntVm e, covariant BigIntVm m) =>
      new BigIntVm(_value.modPow(e._value, m._value));

  /// Returns 1/[this] % m
  ///
  /// (HAC 14.61)
  BigIntVm modInverse(covariant BigIntVm m) =>
      new BigIntVm(_value.modInverse(m._value));

  BigIntVm min(covariant BigIntVm a) =>
      (this.compareTo(a) < 0) ? this : a;

  BigIntVm max(covariant BigIntVm a) =>
      (this.compareTo(a) > 0) ? this : a;

  /// Returns gcd([this], [other])
  ///
  /// (HAC 14.54)
  BigIntVm gcd(covariant BigIntVm other) =>
      new BigIntVm(_value.gcd(other._value));

  /// Returns [this] | (1 << [bitPos]). Does not modify [this].
  BigIntVm setBit(int bitPos) => new BigIntVm(_value | (1 << bitPos));

  /// Returns [this] & ~(1 << [bitPos]). Does not modify [this].
  BigIntVm clearBit(int bitPos) =>
      new BigIntVm(_value & ~(1 << bitPos));

  /// Returns [this] ^ (1 << [bitPos]). Does not modify [this].
  BigIntVm toggleBit(int bitPos) =>
      new BigIntVm(_value ^ (1 << bitPos));

  /// Returns [this] % [n] when n < 2^26
  BigIntVm modInt(int n) => new BigIntVm(_value % n);

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigIntVm modPowInt(int e, covariant BigIntVm m) =>
      new BigIntVm(_value.modPow(e, m._value));

  /// Returns true if value is even
  bool get isEven => _value.isEven;

  /// Returns true if value is odd
  bool get isOdd => _value.isOdd;

  /// Returns number of bits required to represent [this].
  int get bitLength => _value.bitLength;

  /// Returns number of bytes required to represent [this].
  int get byteLength => (bitLength + 7) ~/ 8;

  /// Returns value as [int].
  int get value => _value;

  /// Returns value as 8-bit integer.
  int get value8 => _value & 0xff;

  /// Returns value as 16-bit integer.
  int get value16 => _value & 0xffff;

  /// Returns value as 32-bit integer.
  int get value32 => _value & 0xffffffff;

  /// Returns value as 53-bit integer.
  int get value53 => _value & 0x1fffffffffffff;

  /// Returns true iff bit at position [bitPos] is set.
  bool testBit(int bitPos) => (_value & (1 << bitPos)) != 0;

  int get sign => _value.sign;

  bool get isNegative => _value.isNegative;
}
