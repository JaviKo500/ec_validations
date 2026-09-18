import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/l10n/ec_validations_l10n.dart';

/// Types of Ecuadorian identification documents.
enum TypeIdentification {
  dni,
  ruc,
  rucPersonNatural,
  rucSocietyPrivate,
  rucPublicSociety,
  possiblyValidRuc,
}

/// Result of an identification validation operation.
class IdentificationResult {
  final bool isValid;
  final ErrorCode? typeCodeError;
  final EcMessageKey? messageKey;
  final Map<String, Object?> messageArgs;
  final String? _overrideMessage;
  IdentificationResult({
    required this.isValid,
    String? errorMessage,
    this.typeCodeError,
    this.messageKey,
    this.messageArgs = const {},
  }): _overrideMessage = errorMessage;

  String? get errorMessage => _overrideMessage ??
    (  messageKey == null ? null : EcValidationsL10n.messages.message(messageKey!, messageArgs) );
  
  String? messageIn(EcValidationsMessages messages) => messageKey == null
    ? _overrideMessage
    : messages.message(messageKey!, messageArgs);
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
  final EcMessageKey messageKey;
  final Map<String, Object?> args;

  ValidationRule({required this.pattern, required this.messageKey, this.args = const {}});

  factory ValidationRule.digits(int digits) => ValidationRule(
      pattern: '^\\d{$digits}\$',
      messageKey: EcMessageKey.identificationLengthOrFormat,
      args: {'digits': digits},
    );
}
