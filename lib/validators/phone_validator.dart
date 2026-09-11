import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

/// Validator for Ecuadorian phone numbers.
class PhoneValidator {

  /// Validates if a local Ecuadorian phone number is valid.
  /// 
  /// [phoneNumber] Phone number to validate.
  ///   
  /// Returns a [PhoneResult] with the validation result.
  static PhoneResult isValidLocal( String phoneNumber ) {
    try {
      final validatedNumber = validateLocalPhone( phoneNumber );
      return PhoneResult(
        isValid: true,
        normalizedNumber: validatedNumber,
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

  /// Validates if an international Ecuadorian phone number is valid.
  ///
  /// [phoneNumber] Phone number to validate.
  /// 
  /// Returns a [PhoneResult] with the validation result.
  static PhoneResult isValidInternational( String phoneNumber ) {
    try {
      final validatedNumber = validateInternationalPhone( phoneNumber );
      return PhoneResult(
        isValid: true,
        normalizedNumber: validatedNumber,
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