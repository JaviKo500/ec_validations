
import 'package:ec_validations/ec_validations.dart';
/// Exception thrown during phone validation processes.
class PhoneException implements Exception {
  final PhoneErrorCode code;
  final EcMessageKey key;
  final Map<String, Object?> args;
  /// Creates a new phone validation exception.
  ///
  /// [code] The error code for this exception.
  /// [message] The error message for this exception.
  PhoneException(this.code, this.key, [this.args = const {}]);

  String get message => EcValidationsL10n.messages.message(key, args);

  @override
  String toString() => 'Error $code: $message';
}