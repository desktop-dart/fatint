part of fatint.js;

class BigIntRefJs extends BigIntJs implements BigIntRef {
  final BigIntJs deref;

  BigIntRefJs get ref => this;

  BigInteger get _value => deref._value;

  set _value(BigInteger v) => deref._value = v;

  BigIntRefJs(this.deref);

  BigIntRefJs operator +(covariant BigIntJs other) {
    _value = _value.add(other._value.add);
    return this;
  }

  BigIntRefJs operator -(covariant BigIntJs other) {
    _value = _value.subtract(other._value);
    return this;
  }

  BigIntRefJs operator *(covariant BigIntJs other) {
    _value = _value.multiply(other._value);
    return this;
  }

  BigIntRefJs operator /(covariant BigIntJs other) {
    _value = _value.divide(other._value);
    return this;
  }

  /// Return [this] ~/ [other].
  BigIntRefJs operator ~/(covariant BigIntJs other) {
    _value = _value.divide(other._value);
    return this;
  }

  /// Return [this] % [other].
  BigIntRefJs operator %(covariant BigIntJs other) {
    _value = _value.mod(other._value);
    return this;
  }

  BigIntRefJs operator -() {
    _value = _value.negate();
    return this;
  }

  BigIntRefJs operator &(covariant BigIntJs other) {
    _value = _value.and(other._value);
    return this;
  }

  BigIntRefJs operator |(covariant BigIntJs other) {
    _value = _value.or(other._value);
    return this;
  }

  BigIntRefJs operator ^(covariant BigIntJs other) {
    _value = _value.xor(other._value);
    return this;
  }

  BigIntRefJs operator ~() {
    _value = _value.not();
    return this;
  }

  BigIntRefJs andNot(covariant BigIntJs other) {
    _value = _value.and(other._value.not());
    return this;
  }

  BigIntRefJs operator <<(int n) {
    _value = _value.shiftLeft(n);
    return this;
  }

  BigIntRefJs operator >>(int n) {
    _value = _value.shiftRight(n);
    return this;
  }

  BigIntRefJs abs() {
    _value = _value.abs();
    return this;
  }

  BigIntJs remainder(covariant BigIntJs denominator) {
    _value = _value.remainder(denominator._value);
    return this;
  }

  BigIntJs pow(int e) {
    if (e > 0xffffffff || e < 1) return BigIntJs.one;
    _value = _value.pow(e);
    return this;
  }

  BigIntRefJs modPow(covariant BigIntJs e, covariant BigIntJs m) {
    _value = _value.modPow(e._value, m._value);
    return this;
  }

  BigIntJs modInverse(covariant BigIntJs m) {
    _value = _value.modInv(m._value);
    return this;
  }

  BigIntRefJs min(covariant BigIntJs other) {
    if (_value.compare(other._value) > 0) {
      _value = other._value;
    }
    return this;
  }

  BigIntRefJs max(covariant BigIntJs other) {
    if (_value.compare(other._value) < 0) {
      _value = other._value;
    }
    return this;
  }

  BigIntRefJs gcd(covariant BigIntJs other) {
    _value = MakeBigInt.gcd(_value, other._value);
    return this;
  }

  /// Returns [this] | (1 << [bitPos]).
  BigIntRefJs setBit(int bitPos) {
    _value = _value.or(MakeBigInt.one.shiftLeft(bitPos));
    return this;
  }

  /// Returns [this] & ~(1 << [bitPos]).
  BigIntRefJs clearBit(int bitPos) {
    _value = _value.and(MakeBigInt.one.shiftLeft(bitPos).not());
    return this;
  }

  /// Returns [this] ^ (1 << [bitPos]).
  BigIntRefJs toggleBit(int bitPos) {
    _value = _value.xor(MakeBigInt.one.shiftLeft(bitPos));
    return this;
  }

  /// Returns [this] % [n] when n < 2^26
  BigIntRefJs modInt(int n) {
    _value = _value.mod(n);
    return this;
  }

  /// Returns [this]^[e] % [m] when 0 <= e < 2^32.
  BigIntRefJs modPowInt(int e, covariant BigIntJs m) {
    _value = _value.modPow(e, m._value);
    return this;
  }
}
