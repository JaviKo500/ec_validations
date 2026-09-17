import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

/// Validator for Ecuadorian phone numbers.
///
/// Accepts mobile (`0991234567`) and landline (`022345678`) numbers, in local
/// or international (`+593991234567`) notation.
class PhoneValidator {

  /// Validates if a local Ecuadorian phone number is valid.
  /// 
  /// [phoneNumber] Phone number to validate.
  ///   
  /// Returns a [PhoneResult] with the validation result.
  static PhoneResult isValidLocal( String phoneNumber ) =>
    _evaluate(() => validateLocalPhone( phoneNumber ));

  /// Validates if an international Ecuadorian phone number is valid.
  ///
  /// [phoneNumber] Phone number to validate.
  /// 
  /// Returns a [PhoneResult] with the validation result.
  static PhoneResult isValidInternational( String phoneNumber ) =>
    _evaluate(() => validateInternationalPhone( phoneNumber ));

  /// Validates if an Ecuadorian phone number is valid in either local
  /// (`0991234567`) or international (`+593991234567`) notation.
  ///
  /// [phoneNumber] Phone number to validate.
  ///
  /// Returns a [PhoneResult] with the validation result.
  static PhoneResult isValid( String phoneNumber ) =>
    _evaluate(() => validateInternationalLocalPhone( phoneNumber ));

  /// Runs a validation helper and maps its outcome to a [PhoneResult].
  ///
  /// [validate] Helper returning the normalized number or throwing a
  /// [PhoneException].
  static PhoneResult _evaluate( String Function() validate ) {
    try {
      return PhoneResult(
        isValid: true,
        normalizedNumber: validate(),
        errorMessage: null,
        typeCodeError: null,
      );
    } catch (e) {
      if ( e is PhoneException ) {
        return PhoneResult(
          isValid: false,
          errorMessage: e.message,
          typeCodeError: e.code,
        );
      }

      return PhoneResult(
        isValid: false,
        errorMessage: 'Invalid phone number',
        typeCodeError: PhoneErrorCode.invalidPhone,
      );
    }
  }
}
