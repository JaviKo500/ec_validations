
/// Ecuador country code.
const String ecCountryCode = '+593';

final RegExp _separatorsRegExp = RegExp(r'[\s.()-]');

/// Normalizes the input phone number by removing separators and unifying the
/// international prefix notation (`00593`, `593` and `+593` become `+593`).
///
/// [input] Raw phone number to normalize.
String normalizePhone(String input) {
  String value = input.replaceAll(_separatorsRegExp, '');
  if (value.startsWith('00')) value = '+${value.substring(2)}';
  if (value.startsWith('593')) value = '+$value';

  /// Remove leading zeros after the country code
  if (value.startsWith('${ecCountryCode}0')) {
    value = '$ecCountryCode${value.substring(ecCountryCode.length + 1)}';
  }

  return value;
}
