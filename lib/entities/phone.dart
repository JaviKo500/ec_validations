/// type of phone number
enum PhoneType {
  localPhone,
  internationalPhone,
  internationalLocalPhone,
}

/// result of phone number validation
class PhoneResult {
  final bool isValid;
  final String? errorMessage;
  final PhoneErrorCode? typeCodeError;

  PhoneResult({
    required this.isValid,
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