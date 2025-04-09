import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

/// Validates a number using the "modulo 10" algorithm, commonly used for Ecuadorian national ID numbers.
///
/// [firstDigits] The first 9 digits of the identification number.
/// [verificationDigitString] The verification digit to validate.
///
/// Returns true if the verification digit is valid.
///
/// Throws an [IdentificationException] if the verification digit is invalid or if any part
/// of the identification is not a number.

bool algorithm10(String firstDigits, String verificationDigitString) {
  final verificationDigit = int.tryParse(verificationDigitString);
  if (verificationDigit == null) {
    throw IdentificationException(
      ErrorCode.invalidVerificationDigit,
      'Invalid verification digit: must be a number.',
    );
  }

  const listCoefficients = [2, 1, 2, 1, 2, 1, 2, 1, 2];

  int total = 0;
  for (int i = 0; i < listCoefficients.length; i++) {
    final coefficient = listCoefficients[i];
    final digit = int.tryParse(firstDigits[i]);

    if (digit == null) {
      throw IdentificationException(
        ErrorCode.invalidIdentification,
        'Invalid identification: must be a number.',
      );
    }
    int result = digit * coefficient;
    if (result >= 10) {
      result -= 9;
    }

    total += result;
  }

  final residue = total % 10;

  int  verificationDigitResult = 0;
  if ( residue != 0 ) {
    verificationDigitResult = 10 - residue;
  }
  
  if (verificationDigitResult != verificationDigit) {
    throw IdentificationException(
      ErrorCode.invalidVerificationDigit,
      'Invalid verification digit.',
    );
  }

  return true;
}
