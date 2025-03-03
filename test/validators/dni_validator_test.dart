import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/ec_validations.dart';

void main() {
  group('Dni Validator Tests', () {
    test('Should return true if identification is valid', () {
      final result = DniValidator.isValid('0105566046');
      expect(result.isValid, true);
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('should return invalid result for empty DNI', () {
      final result = DniValidator.isValid('');
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Identification cannot be empty');
      expect(result.typeCodeError, ErrorCode.invalidEmpty);
    });

    test('should return invalid result for DNI with incorrect format', () {
      final result = DniValidator.isValid('123456789');
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Invalid identification: must be exactly 10 digits and contain only numbers.');
      expect(result.typeCodeError, ErrorCode.invalidLengthOrFormat);
    });

    test('should return invalid result for DNI with invalid province code', () {
      final result = DniValidator.isValid('3005566046');
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidCodeProvince);
    });

    test('should return invalid result for DNI with invalid third digit', () {
      final result = DniValidator.isValid('0195566046');
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidThirdDigit);
    });

    test('should return invalid result for DNI with invalid check digit', () {
      final result = DniValidator.isValid('0105566047');
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidVerificationDigit);
    });
  });
}