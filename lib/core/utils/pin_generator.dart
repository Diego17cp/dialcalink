import 'dart:math';

class PinGenerator {
  const PinGenerator._();

  static String generate6DigitPin() {
    final random = Random.secure();
    return (100000 + random.nextInt(900000)).toString();
  }
}
