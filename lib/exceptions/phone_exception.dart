
import 'package:ec_validations/entities/index.dart';

/// Exception thrown during phone validation processes.
class PhoneException implements Exception {
  final String message;
  final PhoneErrorCode code;

  /// Creates a new phone validation exception.
  ///
  /// [code] The error code for this exception.
  /// [message] The error message for this exception.
  PhoneException(this.code, this.message);

  @override
  String toString() => 'Error $code: $message';
}