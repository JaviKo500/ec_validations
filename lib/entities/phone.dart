/// type of phone number
enum PhoneType {
  localPhone,
  internationalPhone,
  internationalLocalPhone,
}

/// result of phone number validation
class PhoneResult {
  final bool isValid;
  /// normalized phone number if valid, otherwise null
  final String? normalizedNumber;
  /// error message if invalid, otherwise null
  final String? errorMessage;
  /// error code if invalid, otherwise null
  final PhoneErrorCode? typeCodeError;

  PhoneResult({
    required this.isValid,
    this.normalizedNumber,
    this.errorMessage,
    this.typeCodeError,
  });
}

/// error code for phone number validation
enum PhoneErrorCode {
  invalidLength,
  invalidFormat,
  invalidCountryCode,
  invalidEmpty,
  invalidPhone,
}

/// rule for validation with pattern matching
class PhoneValidationRule {
  final String pattern;
  final String errorMessage;

  PhoneValidationRule({required this.pattern, required this.errorMessage});
}