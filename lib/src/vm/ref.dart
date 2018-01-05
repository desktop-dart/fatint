part of fatint.dartvm;

class BigIntRefVm extends BigIntVm implements BigIntRef {
  final BigIntVm deref;

  BigIntRefVm get ref => this;

  int get _value => deref._value;

  set _value(int v) => deref._value = v;

  BigIntRefVm(this.deref);

  BigIntRefVm operator +(covariant BigIntVm other) {
    _value += other._value;
    return this;
  }

  BigIntRefVm operator -(covariant BigIntVm other) {
    _value -= other._value;
    return this;
  }

  BigIntRefVm operator *(covariant BigIntVm other) {
    _value *= other._value;
    return this;
  }

  BigIntRefVm operator /(covariant BigIntVm other) {
    _value ~/= other._value;
    return this;
  }

  /// Return [this] ~/ [other].
  BigIntRefVm operator ~/(covariant BigIntVm other) {
    _value ~/= other._value;
    return this;
  }

  /// Return [this] % [other].
  BigIntRefVm operator %(covariant BigIntVm other) {
    _value %= other._value;
    return this;
  }

  BigIntRefVm operator -() {
    _value = -_value;
    return this;
  }

  BigIntRefVm operator &(covariant BigIntVm other) {
    _value &= other._value;
    return this;
  }

  BigIntRefVm operator |(covariant BigIntVm other) {
    _value |= other._value;
    return this;
  }

  BigIntRefVm operator ^(covariant BigIntVm other) {
    _value ^= other._value;
    return this;
  }

  BigIntRefVm operator ~() {
    _value = ~_value;
    return this;
  }

  BigIntRefVm andNot(covariant BigIntVm other) {
    _value &= ~other._value;
    return this;
  }

  BigIntRefVm operator <<(int n) {
    _value <<= n;
    return this;
  }

  BigIntRefVm operator >>(int n) {
    _value >>= n;
    return this;
  }

  BigIntRefVm abs() {
    _value = _value.abs();
    return this;
  }

  BigIntRefVm remainder(covariant BigIntVm denominator) {
    _value = _value.remainder(denominator._value);
    return this;
  }

  BigIntRefVm pow(int e) {
    if (e > 0xffffffff || e < 1) return BigIntVm.one;
    _value = math.pow(_value, e);
    return this;
  }

  BigIntRefVm modPow(covariant BigIntVm e, covariant BigIntVm m) {
    _value = _value.modPow(e._value, m._value);
    return this;
  }

  BigIntRefVm modInverse(covariant BigIntVm m) {
    _value = _value.modInverse(m._value);
    return this;
  }

  BigIntRefVm min(covariant BigIntVm other) {
    _value = math.min(_value, other._value);
    return this;
  }

  BigIntRefVm max(covariant BigIntVm other) {
    _value = math.max(_value, other._value);
    return this;
  }

  BigIntRefVm gcd(covariant BigIntVm other) {
    _value = _value.gcd(other._value);
    return this;
  }

  /// Returns [this] | (1 << [bitPos]).
  BigIntRefVm setBit(int bitPos) {
    _value |= 1 << bitPos;
    return this;
  }

  /// Returns [this] & ~(1 << [bitPos]).
  BigIntRefVm clearBit(int bitPos) {
    _value &= ~(1 << bitPos);
    return this;
  }

  /// Returns [this] ^ (1 << [bitPos]).
  BigIntRefVm toggleBit(int bitPos) {
    _value ^= 1 << bitPos;
    return this;
  }

  /// Returns [this] % [n] when n < 2^26
  BigIntRefVm modInt(int n) {
    _value %= n;
    return this;
  }

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigIntRefVm modPowInt(int e, covariant BigIntVm m) {
    _value = _value.modPow(e, m._value);
    return this;
  }
}
