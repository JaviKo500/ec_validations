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
      'Identification cannot be empty',
    );
  }

  final ruler = mapRules[typeIdentification];

  if (ruler == null) {
    throw IdentificationException(
      ErrorCode.invalidType,
      'Invalid identification type',
    );
  }

  final regExp = RegExp(ruler.pattern);

  if (!regExp.hasMatch(identification)) {
    throw IdentificationException(
      ErrorCode.invalidLengthOrFormat,
      ruler.errorMessage,
    );
  }
}

final Map<TypeIdentification, ValidationRule> mapRules = {
  TypeIdentification.dni: ValidationRule(
    pattern: r'^\d{10}$',
    errorMessage:
        'Invalid identification: must be exactly 10 digits and contain only numbers.',
  ),
  TypeIdentification.ruc: ValidationRule(
    pattern: r'^\d{13}$',
    errorMessage:
        'Invalid identification: must be exactly 13 digits and contain only numbers.',
  ),
  TypeIdentification.rucPersonNatural: ValidationRule(
    pattern: r'^\d{13}$',
    errorMessage:
        'Invalid identification: must be exactly 13 digits and contain only numbers.',
  ),
  TypeIdentification.rucPublicSociety: ValidationRule(
    pattern: r'^\d{13}$',
    errorMessage:
        'Invalid identification: must be exactly 13 digits and contain only numbers.',
  ),
  TypeIdentification.rucSocietyPrivate: ValidationRule(
    pattern: r'^\d{13}$',
    errorMessage:
        'Invalid identification: must be exactly 13 digits and contain only numbers.',
  ),
};
