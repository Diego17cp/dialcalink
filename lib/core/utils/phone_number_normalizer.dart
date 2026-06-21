class PhoneNumberNormalizer {
  const PhoneNumberNormalizer._();

  static const int kMinimumComparableLength = 8;

  static String digitsOnly(String phoneNumber) =>
      phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  static bool matches(String incoming, String stored) {
    final a = digitsOnly(incoming);
    final b = digitsOnly(stored);

    if (a.length < kMinimumComparableLength ||
        b.length < kMinimumComparableLength) {
      return false;
    }

    final shorterLength = a.length < b.length ? a.length : b.length;
    final suffixA = a.substring(a.length - shorterLength);
    final suffixB = b.substring(b.length - shorterLength);

    return suffixA == suffixB;
  }

  static String suffixForNativeFilter(
    String incoming, {
    int length = kMinimumComparableLength,
  }) {
    final digits = digitsOnly(incoming);
    if (digits.length < length) {
      return digits;
    }
    return digits.substring(digits.length - length);
  }
}
