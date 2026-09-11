
import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

final _localPhoneRegExp = RegExp(r'^09\d{8}$');

/// Validates a local Ecuadorian phone number.
/// 
void validateLocalPhone(String phoneNumber) {
  final value = phoneNumber.trim();
  if (value.isEmpty) {
    throw PhoneException(
      PhoneErrorCode.invalidEmpty,
      'Phone number cannot be empty.'
    );
  }

  if ( value.length !=10) {
    throw PhoneException(
      PhoneErrorCode.invalidLength,
      'Phone number must be exactly 10 digits long.'
    );
  }

  if (!_localPhoneRegExp.hasMatch(value)) {
    throw PhoneException(
      PhoneErrorCode.invalidFormat,
      'Phone number must start with 09 and contain exactly 10 digits.'
    );
  }
}