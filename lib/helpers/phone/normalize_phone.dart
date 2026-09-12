
/// Ecuador country code.
const String ecCountryCode = '+593';

final RegExp _separatorsRegExp = RegExp(r'[\s.()-]');

/// Removes the separators commonly used to write a phone number: spaces,
/// dots, dashes and parentheses.
///
/// [input] Raw phone number.
String stripPhoneSeparators(String input) =>
  input.replaceAll(_separatorsRegExp, '');

/// Normalizes the input phone number by removing separators and unifying the
/// international prefix notation (`00593`, `593` and `+593` become `+593`).
///
/// [input] Raw phone number to normalize.
String normalizePhone(String input) {
  String value = stripPhoneSeparators(input);
  if (value.startsWith('00')) value = '+${value.substring(2)}';
  if (value.startsWith('593')) value = '+$value';

  /// Remove leading zeros after the country code
  if (value.startsWith('${ecCountryCode}0')) {
    value = '$ecCountryCode${value.substring(ecCountryCode.length + 1)}';
  }

  return value;
}
