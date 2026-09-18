import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

/// Validator for Ecuadorian national ID numbers.
class DniValidator {
  /// Validates if an Ecuadorian national ID number is valid.
  ///
  /// [identification] ID number to validate.
  ///
  /// Returns an [IdentificationResult] with the validation result.
  static IdentificationResult isValid(String identification) {
    try {
      initValidate(identification, TypeIdentification.dni);
      validateCodeProvince(identification.substring(0, 2));
      validateThirdDigit(
        identification.substring(2, 3),
        TypeIdentification.dni,
      );
      algorithm10(
        identification.substring(0, 9),
        identification.substring(9, 10),
      );
      return IdentificationResult(
        isValid: true,
        errorMessage: null,
        typeCodeError: null,
      );
    } catch (e) {
      if (e is IdentificationException) {
        return IdentificationResult(
          isValid: false,
          messageKey: e.key,
          messageArgs: e.args,
          typeCodeError: e.code
        );
      }
      return IdentificationResult(
        isValid: false,
        typeCodeError: ErrorCode.invalidIdentification,
        messageKey: EcMessageKey.identificationInvalid,
      );
    }
  }
}
