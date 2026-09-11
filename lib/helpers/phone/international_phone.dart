

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

const String _ecCode = '+593';
final RegExp _separatorsRegExp = RegExp(r'[\s.()-]');

/// Validates an international Ecuadorian phone number.
/// 
/// 
/// [phoneNumber] Phone number to validate.
String  validateInternationalPhone(String phoneNumber) {
  final value = _normalize(phoneNumber);

  if (value.isEmpty) {
    throw PhoneException(
      PhoneErrorCode.invalidEmpty,
      'Phone number cannot be empty.'
    );
  }

  if (!value.startsWith(_ecCode)) {
    throw PhoneException(
      PhoneErrorCode.invalidCountryCode,
      'Phone number must start with the Ecuador country code $_ecCode.'
    );
  }

  validateLocalPhone('0${value.substring(_ecCode.length)}');
  return value;
}

/// Normalizes the input phone number by removing separators and ensuring it starts with the Ecuador country code.
String _normalize( String input ) {
  String value = input.replaceAll(_separatorsRegExp, '');
  if ( value.startsWith('00') ) value = '+${value.substring(2)}';
  if ( value.startsWith('593')) value = '+$value';

  /// Remove leading zeros after the country code
  if ( value.startsWith('${_ecCode}0') ) {
    value = '$_ecCode${value.substring(_ecCode.length + 1)}';
  }

  return value;
}