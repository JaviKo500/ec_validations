

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

/// Validates an international Ecuadorian phone number: the Ecuador country
/// code `+593` followed by a mobile (`9…`) or landline (`2…` to `7…`) number.
///
/// [phoneNumber] Phone number to validate.
String  validateInternationalPhone(String phoneNumber) {
  final value = normalizePhone(phoneNumber);

  if (value.isEmpty) {
    throw PhoneException(
      PhoneErrorCode.invalidEmpty,
      'Phone number cannot be empty.'
    );
  }

  if (!value.startsWith(ecCountryCode)) {
    throw PhoneException(
      PhoneErrorCode.invalidCountryCode,
      'Phone number must start with the Ecuador country code $ecCountryCode.'
    );
  }

  /// The local helper reports the lengths and prefixes of the local notation,
  /// so its errors are rewritten to describe the number as it was typed.
  try {
    validateLocalPhone('0${value.substring(ecCountryCode.length)}');
  } on PhoneException catch (e) {
    if (e.code == PhoneErrorCode.invalidLength) {
      throw PhoneException(
        PhoneErrorCode.invalidLength,
        'Phone number must have exactly 9 digits after $ecCountryCode for a '
        'mobile number or 8 for a landline number.'
      );
    }

    if (e.code == PhoneErrorCode.invalidFormat) {
      throw PhoneException(
        PhoneErrorCode.invalidFormat,
        'Phone number must continue with 9 for a mobile number or with 2 to 7 '
        'for a landline number after $ecCountryCode.'
      );
    }

    rethrow;
  }

  return value;
}
