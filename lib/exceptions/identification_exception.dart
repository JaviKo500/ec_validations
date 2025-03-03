import 'package:ec_validations/entities/index.dart';

/// Exception thrown during identification validation processes.
class IdentificationException implements Exception {
  final String message;
  final ErrorCode code;

  /// Creates a new identification validation exception.
  ///
  /// [code] The error code for this exception.
  /// [message] The error message for this exception.
  IdentificationException(this.code, this.message);

  @override
  String toString() => 'Error $code: $message';
}