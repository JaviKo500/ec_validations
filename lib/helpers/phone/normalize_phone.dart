
/// Ecuador country code.
const String ecCountryCode = '+593';

/// Ecuador country code without the leading plus sign.
final String _ecDialCode = ecCountryCode.substring(1);

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
/// A leading `00` is only treated as an international prefix when the Ecuador
/// country code follows it, so a local number is never mistaken for one.
///
/// [input] Raw phone number to normalize.
String normalizePhone(String input) {
  String value = stripPhoneSeparators(input);
  if (value.startsWith('00$_ecDialCode')) value = '+${value.substring(2)}';
  if (value.startsWith(_ecDialCode)) value = '+$value';

  /// Remove leading zeros after the country code
  if (value.startsWith('${ecCountryCode}0')) {
    value = '$ecCountryCode${value.substring(ecCountryCode.length + 1)}';
  }

  return value;
}
