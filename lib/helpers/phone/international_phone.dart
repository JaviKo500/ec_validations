

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

  validateLocalPhone('0${value.substring(ecCountryCode.length)}');
  return value;
}
