/// Types of Ecuadorian identification documents.
enum TypeIdentification {
  dni,
  ruc,
  rucPersonNatural,
  rucSocietyPrivate,
  rucPublicSociety,
}

/// Result of an identification validation operation.
class IdentificationResult {
  final bool isValid;
  final String? errorMessage;
  final ErrorCode? typeCodeError;

  IdentificationResult({
    required this.isValid,
    this.errorMessage,
    this.typeCodeError,
  });
}

/// Error codes for identification validation failures.
enum ErrorCode {
  invalidIdentification,
  invalidThirdDigit,
  invalidVerificationDigit,
  invalidCodeEstablishment,
  invalidEmpty,
  invalidLengthOrFormat,
  invalidCodeProvince,
  invalidType,
  invalidCheckDigit,
}

/// Rule for validation with pattern matching.
class ValidationRule {
  final String pattern;
  final String errorMessage;

  ValidationRule({required this.pattern, required this.errorMessage});
}
