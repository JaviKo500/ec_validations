import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

/// Validate third digit of identification number.
///
/// [thirdDigit] The identification.substring(2, 3) digits of the identification number.
/// [typeIdentification] The type of identification being validated.
///
/// Throws an [IdentificationException] if the verification digit is invalid or
/// thirdDigit is less than 0 or greater than 9 for DNI and RUC Person Natural.
/// thirdDigit is different than 9 for RUC Society Private
/// thirdDigit is different than 6 for RUC Public Society.

void validateThirdDigit(
  String thirdDigit,
  TypeIdentification typeIdentification,
) {
  final thirdDigitInt = int.tryParse(thirdDigit);
  if (thirdDigitInt == null) {
    throw IdentificationException(
      ErrorCode.invalidThirdDigit,
      'Invalid third digit: must be a number.',
    );
  }

  switch (typeIdentification) {
    case TypeIdentification.dni:
    case TypeIdentification.rucPersonNatural:
      if (thirdDigitInt < 0 || thirdDigitInt > 9) {
        throw IdentificationException(
          ErrorCode.invalidThirdDigit,
          'Invalid third digit: must be a number between 0 and 9.',
        );
      }
      break;
    case TypeIdentification.rucSocietyPrivate:
      if (thirdDigitInt != 9) {
        throw IdentificationException(
          ErrorCode.invalidThirdDigit,
          'Invalid third digit: must be a number equal to 9.',
        );
      }
      break;
    case TypeIdentification.rucPublicSociety:
      if (thirdDigitInt != 6) {
        throw IdentificationException(
          ErrorCode.invalidThirdDigit,
          'Invalid third digit: must be a number equal to 6.',
        );
      }
      break;
    default:
      throw IdentificationException(
        ErrorCode.invalidType,
        'Invalid identification type',
      );
  }
}
