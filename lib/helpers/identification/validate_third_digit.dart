import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

void validateThirdDigit ( String thirdDigit, TypeIdentification typeIdentification ) {
  final thirdDigitInt = int.tryParse(thirdDigit);
  if ( thirdDigitInt == null ) {
    throw IdentificationException(
      ErrorCode.invalidThirdDigit,
      'Invalid third digit: must be a number.'
    );
  }

  switch ( typeIdentification ) {
    case TypeIdentification.dni:
    case TypeIdentification.rucPersonNatural:
      if ( thirdDigitInt < 0 || thirdDigitInt > 5 ) {
        throw IdentificationException(
          ErrorCode.invalidThirdDigit,
          'Invalid third digit: must be a number between 0 and 5.'
        );
      }
      break;
    case TypeIdentification.rucSocietyPrivate:
      if ( thirdDigitInt != 9 ) {
        throw IdentificationException(
          ErrorCode.invalidThirdDigit,
          'Invalid third digit: must be a number equal to 9.'
        );
      }
      break;
    case TypeIdentification.rucPublicSociety:
      if ( thirdDigitInt != 6 ) {
        throw IdentificationException(
          ErrorCode.invalidThirdDigit,
          'Invalid third digit: must be a number equal to 6.'
        );
      }
      break;
    default:
      throw IdentificationException(
        ErrorCode.invalidType,
        'Invalid identification type'
      );
  }
}