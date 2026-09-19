import 'package:ec_validations/entities/ec_validations_messages.dart';
import 'package:ec_validations/l10n/ec_validations_l10n.dart';

/// result of phone number validation
class PhoneResult {
  final bool isValid;
  /// normalized phone number if valid, otherwise null
  final String? normalizedNumber;
  /// error code if invalid, otherwise null
  final PhoneErrorCode? typeCodeError;

  final EcMessageKey? messageKey;
  final Map<String, Object?> messageArgs;
  final String? _overrideMessage;

  PhoneResult({
    required this.isValid,
    this.normalizedNumber,
    String? errorMessage,
    this.typeCodeError,
    this.messageKey,
    this.messageArgs = const {},

  }): _overrideMessage = errorMessage;

  String? get errorMessage => _overrideMessage ??
    ( messageKey == null ? null : EcValidationsL10n.messages.message(messageKey!, messageArgs) );

  String? messageIn( EcValidationsMessages messages) => messageKey == null
    ? _overrideMessage
    : messages.message(messageKey!, messageArgs);
}

/// error code for phone number validation
enum PhoneErrorCode {
  invalidLength,
  invalidFormat,
  invalidCountryCode,
  invalidEmpty,
  invalidPhone,
}
