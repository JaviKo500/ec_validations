import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/ec_validations.dart';

void main() {
  group('Phone Validator isValidLocal Tests', () {
    test('Should return a valid result for a local phone number', () {
      final result = PhoneValidator.isValidLocal('0991234567');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, '0991234567');
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('Should return an invalid result for an empty phone number', () {
      final result = PhoneValidator.isValidLocal('');

      expect(result.isValid, isFalse);
      expect(result.normalizedNumber, null);
      expect(result.errorMessage, 'Phone number cannot be empty.');
      expect(result.typeCodeError, PhoneErrorCode.invalidEmpty);
    });
  });

  group('Phone Validator isValidInternational Tests', () {
    test('Should return a valid result for an international phone number', () {
      final result = PhoneValidator.isValidInternational('+593991234567');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, '+593991234567');
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('Should return an invalid result for a foreign country code', () {
      final result = PhoneValidator.isValidInternational('+1991234567');

      expect(result.isValid, isFalse);
      expect(result.normalizedNumber, null);
      expect(result.errorMessage, 'Phone number must start with the Ecuador country code +593.');
      expect(result.typeCodeError, PhoneErrorCode.invalidCountryCode);
    });
  });

  group('Phone Validator isValid Tests', () {
    test('Should return a valid result for a local phone number', () {
      final result = PhoneValidator.isValid('099 123 4567');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, '0991234567');
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('Should return a valid result for an international phone number', () {
      final result = PhoneValidator.isValid('+593991234567');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, '+593991234567');
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('Should return an invalid result for a phone number with a wrong prefix', () {
      final result = PhoneValidator.isValid('0891234567');

      expect(result.isValid, isFalse);
      expect(result.normalizedNumber, null);
      expect(result.errorMessage, 'Phone number must start with 09 for a mobile number or with 02 to 07 for a landline number.');
      expect(result.typeCodeError, PhoneErrorCode.invalidFormat);
    });
  });

  group('Phone Validator landline Tests', () {
    test('Should return a valid result for a local landline number', () {
      final result = PhoneValidator.isValidLocal('02 234 5678');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, '022345678');
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('Should return a valid result for an international landline number', () {
      final result = PhoneValidator.isValidInternational('+59322345678');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, '+59322345678');
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('Should return a valid result for a landline number in both notations', () {
      expect(PhoneValidator.isValid('022345678').normalizedNumber, '022345678');
      expect(PhoneValidator.isValid('+59322345678').normalizedNumber, '+59322345678');
    });

    test('Should return an invalid result for an invalid area code', () {
      final result = PhoneValidator.isValid('012345678');

      expect(result.isValid, isFalse);
      expect(result.normalizedNumber, null);
      expect(result.typeCodeError, PhoneErrorCode.invalidFormat);
    });
  });
}
