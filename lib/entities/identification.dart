enum TypeIdentification {
  dni,
  ruc,
  rucPersonNatural,
  rucSocietyPrivate,
  rucPublicSociety,
}

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

class ValidationRule {
  final String pattern;
  final String errorMessage;

  ValidationRule({
    required this.pattern,
    required this.errorMessage,
  });
}