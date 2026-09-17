
import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/phone/normalize_phone.dart';

/// Mobile numbers: `09` plus 8 digits.
final _mobilePhoneRegExp = RegExp(r'^09\d{8}$');

/// Landline numbers: `0` plus the area code (`2` to `7`) plus 7 digits.
final _landlinePhoneRegExp = RegExp(r'^0[2-7]\d{7}$');

/// Validates a local Ecuadorian phone number, either mobile (10 digits
/// starting with `09`) or landline (9 digits starting with `02` to `07`).
///
/// [phoneNumber] Phone number to validate.
String validateLocalPhone(String phoneNumber) {
  final value = stripPhoneSeparators(phoneNumber);
  if (value.isEmpty) {
    throw PhoneException(
      PhoneErrorCode.invalidEmpty,
      'Phone number cannot be empty.'
    );
  }

  if (value.length != 10 && value.length != 9) {
    throw PhoneException(
      PhoneErrorCode.invalidLength,
      'Phone number must be exactly 10 characters long for a mobile number '
      'or 9 for a landline number.'
    );
  }

  if (!_mobilePhoneRegExp.hasMatch(value) &&
      !_landlinePhoneRegExp.hasMatch(value)) {
    throw PhoneException(
      PhoneErrorCode.invalidFormat,
      'Phone number must start with 09 for a mobile number or with 02 to 07 '
      'for a landline number.'
    );
  }

  return value;
}
