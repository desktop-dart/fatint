# fatint

Dart library for arbitrary sized integer values. Dart VM by default 
supports arbitrary sized integers but it is not the case when compiled
to Javascript on the browser. This package provides a common big number
interface for DartVM and browser and provides respective implementations.

# Simple examples

```dart
BigInteger i1 = bigInt(25) % bigInt(7); // => 4
BigInteger i2 = bigHex('abcd1234') * bigHex('beef'); // => 0x802297f6968c
```

# Advantage

+ Clean API complying to to Dart's int
+ Efficient equations using `BigIntegerRef` and `zero`