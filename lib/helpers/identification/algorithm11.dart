

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

/// Validates a number using the "modulo 11" algorithm, used for Ecuadorian RUC numbers.
///
/// [initialDigits] The initial digits of the RUC number.
/// [verificationDigitString] The verification digit to validate.
/// [typeIdentification] The type of identification being validated.
///
/// Returns true if the verification digit is valid.
/// 
/// Throws an [IdentificationException] if the verification digit is invalid, the identification
/// type is not supported, or if any part of the identification is not a number.

bool algorithm11 ( String initialDigits, String verificationDigitString, TypeIdentification typeIdentification ) {
  final coefficients = listCoefficients[typeIdentification];

  if (coefficients == null) {
    throw IdentificationException(
      ErrorCode.invalidType,
      'Invalid identification type'
    );
  }

  final verificationDigit = int.tryParse(verificationDigitString);

  if (verificationDigit == null) {
    throw IdentificationException(
      ErrorCode.invalidVerificationDigit,
      'Invalid verification digit: must be a number.',
    );
  }

  final listDigits = initialDigits.split('').map((e) => int.parse(e)).toList();

  if ( listDigits.length != coefficients.length ) {
    throw IdentificationException(
      ErrorCode.invalidType,
      'Invalid identification type'
    );
  }

  int total = 0;

  for (int i = 0; i < listDigits.length; i++) {
    total += listDigits[i] * coefficients[i];
  }

  final remainder = total % 11;

  final result = remainder == 0 ? 0 : 11 - remainder;

  if (result != verificationDigit) {
    throw IdentificationException(
      ErrorCode.invalidVerificationDigit,
      'Invalid verification digit.',
    );
  }

  return true;
}

const Map<TypeIdentification, List<int>> listCoefficients = {
  TypeIdentification.rucSocietyPrivate: [4, 3, 2, 7, 6, 5, 4, 3, 2],
  TypeIdentification.rucPublicSociety: [3, 2, 7, 6, 5, 4, 3, 2],
};