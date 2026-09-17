

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

/// Validates an Ecuadorian phone number written either in local (`0991234567`)
/// or international (`+593991234567`) notation.
///
/// The format is detected after normalization, so separators such as spaces,
/// dots, dashes and parentheses are accepted in both notations.
///
/// Only mobile numbers are supported; landline numbers are rejected.
///
/// [phoneNumber] Phone number to validate.
///
/// Returns the normalized number, keeping the notation of the input.
String validateInternationalLocalPhone(String phoneNumber) {
  final value = normalizePhone(phoneNumber);

  if (value.isEmpty) {
    throw PhoneException(
      PhoneErrorCode.invalidEmpty,
      'Phone number cannot be empty.'
    );
  }

  return value.startsWith('+')
    ? validateInternationalPhone(value)
    : validateLocalPhone(value);
}
