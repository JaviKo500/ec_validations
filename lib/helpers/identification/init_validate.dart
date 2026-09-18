import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

/// Validates a numbers used for Ecuadorian RUC or DNI numbers.
///
/// [identification] The identification number to validate.
/// [typeIdentification] The type of identification being validated.
///
/// Throws an [IdentificationException] if the verification digit is invalid, the identification
/// type is not supported, or if any part of the identification is not a number.

void initValidate(
  String identification,
  TypeIdentification typeIdentification,
) {
  if (identification.isEmpty || identification.trim().isEmpty) {
    throw IdentificationException(
      ErrorCode.invalidEmpty,
      EcMessageKey.identificationEmpty,
    );
  }

  final ruler = mapRules[typeIdentification];

  if (ruler == null) {
    throw IdentificationException(
      ErrorCode.invalidType,
      EcMessageKey.identificationInvalidType,
    );
  }

  final regExp = RegExp(ruler.pattern);

  if (!regExp.hasMatch(identification)) {
    throw IdentificationException(
      ErrorCode.invalidLengthOrFormat,
      ruler.messageKey,
      ruler.args,
    );
  }
}

final Map<TypeIdentification, ValidationRule> mapRules = {
  TypeIdentification.dni: ValidationRule.digits(10),
  TypeIdentification.ruc: ValidationRule.digits(13),
  TypeIdentification.rucPersonNatural: ValidationRule.digits(13),
  TypeIdentification.rucPublicSociety: ValidationRule.digits(13),
  TypeIdentification.rucSocietyPrivate: ValidationRule.digits(13),
};
