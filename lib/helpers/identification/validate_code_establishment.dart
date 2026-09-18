import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

/// Validate codeEstablishment of identification number.
///
/// [codeEstablishment] The identification.substring(10, 13) digits of the identification number.
///
/// Throws an [IdentificationException] if the verification digit is invalid or codeEstablishment is less than 0

void validateCodeEstablishment(String codeEstablishment) {
  final code = int.tryParse(codeEstablishment);
  if (code == null) {
    throw IdentificationException(
      ErrorCode.invalidCodeEstablishment,
      EcMessageKey.codeEstablishmentNotNumber,
    );
  }

  if (code <= 0) {
    throw IdentificationException(
      ErrorCode.invalidCodeEstablishment,
      EcMessageKey.codeEstablishmentZero,
    );
  }
}
