part of fatint.dartvm;

class BigIntegerRefVM extends BigIntegerVM implements BigIntegerRef {
  final BigIntegerVM deref;

  BigIntegerRefVM get ref => this;

  int get _value => deref._value;

  set _value(int v) => deref._value = v;

  BigIntegerRefVM(this.deref);

  BigIntegerRefVM operator +(covariant BigIntegerVM other) {
    _value += other._value;
    return this;
  }

  BigIntegerRefVM operator -(covariant BigIntegerVM other) {
    _value -= other._value;
    return this;
  }

  BigIntegerRefVM operator *(covariant BigIntegerVM other) {
    _value *= other._value;
    return this;
  }

  BigIntegerRefVM operator /(covariant BigIntegerVM other) {
    _value ~/= other._value;
    return this;
  }

  /// Return [this] ~/ [other].
  BigIntegerRefVM operator ~/(covariant BigIntegerVM other) {
    _value ~/= other._value;
    return this;
  }

  /// Return [this] % [other].
  BigIntegerRefVM operator %(covariant BigIntegerVM other) {
    _value %= other._value;
    return this;
  }

  BigIntegerRefVM operator -() {
    _value = -_value;
    return this;
  }

  BigIntegerRefVM operator &(covariant BigIntegerVM other) {
    _value &= other._value;
    return this;
  }

  BigIntegerRefVM operator |(covariant BigIntegerVM other) {
    _value |= other._value;
    return this;
  }

  BigIntegerRefVM operator ^(covariant BigIntegerVM other) {
    _value ^= other._value;
    return this;
  }

  BigIntegerRefVM operator ~() {
    _value = ~_value;
    return this;
  }

  BigIntegerRefVM andNot(covariant BigIntegerVM other) {
    _value &= ~other._value;
    return this;
  }

  BigIntegerRefVM operator <<(int n) {
    _value <<= n;
    return this;
  }

  BigIntegerRefVM operator >>(int n) {
    _value >>= n;
    return this;
  }

  BigIntegerRefVM abs() {
    _value = _value.abs();
    return this;
  }

  BigIntegerVM remainder(covariant BigIntegerVM denominator) {
    _value = _value.remainder(denominator._value);
    return this;
  }

  BigIntegerVM pow(int e) {
    if (e > 0xffffffff || e < 1) return BigIntegerVM.one;
    _value = math.pow(_value, e);
    return this;
  }

  BigIntegerRefVM modPow(covariant BigIntegerVM e, covariant BigIntegerVM m) {
    _value = _value.modPow(e._value, m._value);
    return this;
  }

  BigIntegerVM modInverse(covariant BigIntegerVM m) {
    _value = _value.modInverse(m._value);
    return this;
  }

  BigIntegerRefVM min(covariant BigIntegerVM other) {
    _value = math.min(_value, other._value);
    return this;
  }

  BigIntegerRefVM max(covariant BigIntegerVM other) {
    _value = math.max(_value, other._value);
    return this;
  }

  BigIntegerRefVM gcd(covariant BigIntegerVM other) {
    _value = _value.gcd(other._value);
    return this;
  }

  /// Returns [this] | (1 << [bitPos]).
  BigIntegerRefVM setBit(int bitPos) {
    _value |= 1 << bitPos;
    return this;
  }

  /// Returns [this] & ~(1 << [bitPos]).
  BigIntegerRefVM clearBit(int bitPos) {
    _value &= ~(1 << bitPos);
    return this;
  }

  /// Returns [this] ^ (1 << [bitPos]).
  BigIntegerRefVM toggleBit(int bitPos) {
    _value ^= 1 << bitPos;
    return this;
  }

  /// Returns [this] % [n] when n < 2^26
  BigIntegerRefVM modInt(int n) {
    _value %= n;
    return this;
  }

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigIntegerRefVM modPowInt(int e, covariant BigIntegerVM m) {
    _value = _value.modPow(e, m._value);
  }
}
