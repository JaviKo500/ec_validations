
import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/phone/normalize_phone.dart';

final _localPhoneRegExp = RegExp(r'^09\d{8}$');

/// Validates a local Ecuadorian mobile phone number: 10 digits starting with
/// `09`. Landline numbers are not supported.
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

  if ( value.length !=10) {
    throw PhoneException(
      PhoneErrorCode.invalidLength,
      'Phone number must be exactly 10 characters long.'
    );
  }

  if (!_localPhoneRegExp.hasMatch(value)) {
    throw PhoneException(
      PhoneErrorCode.invalidFormat,
      'Phone number must start with 09 and contain exactly 10 digits.'
    );
  }

  return value;
}