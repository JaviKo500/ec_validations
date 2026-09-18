import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/l10n/ec_validations_l10n.dart';

/// Exception thrown during identification validation processes.
class IdentificationException implements Exception {
  final EcMessageKey key;
  final ErrorCode code;
  final Map<String, Object?> args;

  /// Creates a new identification validation exception.
  ///
  /// [code] The error code for this exception.
  /// [key] The message key describing this exception.
  /// [args] Values the message needs, such as the expected number of digits.
  IdentificationException(this.code, this.key, [this.args = const{}]);

  String  get message => EcValidationsL10n.messages.message(key, args);

  @override
  String toString() => 'Error $code: $message';
}
