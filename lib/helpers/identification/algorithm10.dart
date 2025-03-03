import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

bool algorithm10 ( String firstDigits, String verificationDigitString ) {
  final verificationDigit = int.tryParse(verificationDigitString);
  if (verificationDigit == null) {
    throw IdentificationException(
      ErrorCode.invalidVerificationDigit,
      'Invalid verification digit: must be a number.',
    );
  }
  
  const listCoefficients = [2, 1, 2, 1, 2, 1, 2, 1, 2];

  int total= 0;
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
    if ( result >= 10 ) {
      result -= 9;
    }

    total += result;
  }

  final residue = total % 10;

  final  verificationDigitResult = 10 - residue;

  if (verificationDigitResult != verificationDigit) {
    throw IdentificationException(
      ErrorCode.invalidVerificationDigit,
      'Invalid verification digit.',
    );
  }

  return true;
}