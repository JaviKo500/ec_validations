import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/ec_validations.dart';

void main() {
  group('Ruc Validator Tests validateRucByType', () {

    test('should return valid result for correct RUC Person Natural', () {
      final result = RucValidator.validateRucByType('0105566046001', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });
    
    test('should return valid result for correct RUC Private Society', () {
      final result = RucValidator.validateRucByType('1790011674001', TypeIdentification.rucSocietyPrivate);
      
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });
    
    test('should return valid result for correct RUC Public Society', () {
      final result = RucValidator.validateRucByType('1760004650001', TypeIdentification.rucPublicSociety);
      
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });

    test('should return invalid result for empty RUC', () {
      final result = RucValidator.validateRucByType('', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Identification cannot be empty');
      expect(result.typeCodeError, ErrorCode.invalidEmpty);
    });
    
    test('should return invalid result for RUC with incorrect format', () {
      final result = RucValidator.validateRucByType('0105566046', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Invalid identification: must be exactly 13 digits and contain only numbers.');
      expect(result.typeCodeError, ErrorCode.invalidLengthOrFormat);
    });
    
    test('should return invalid result for RUC with invalid province code', () {
      final result = RucValidator.validateRucByType('9905566046001', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidCodeProvince);
    });
    
    test('should return invalid result for RUC Person Natural with invalid third digit', () {
      final result = RucValidator.validateRucByType('0185566046001', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidThirdDigit);
    });
    
    test('should return invalid result for RUC Society Private with invalid third digit', () {
      final result = RucValidator.validateRucByType('1780011674001', TypeIdentification.rucSocietyPrivate);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidThirdDigit);
    });
    
    test('should return invalid result for RUC Public Society with invalid third digit', () {
      final result = RucValidator.validateRucByType('1750004650001', TypeIdentification.rucPublicSociety);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidThirdDigit);
    });
    
    test('should return invalid result for RUC with invalid establishment code', () {
      final result = RucValidator.validateRucByType('0105566046000', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidCodeEstablishment);
    });
    
    test('should return invalid result for RUC with invalid check digit', () {
      final result = RucValidator.validateRucByType('0105566045001', TypeIdentification.rucPersonNatural);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidVerificationDigit);
    });
    
    test('should return invalid result for invalid identification type', () {
      final result = RucValidator.validateRucByType('0105566046001', TypeIdentification.ruc);
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidType);
    });
  });

   group('Ruc Validator Tests validateRuc', () {

    test('should return valid result for correct RUC', () {
      final result = RucValidator.validateRuc('0105566046001');
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });

    test('should return valid result for valid RUC Society Private', () {
      final result = RucValidator.validateRuc('1790011674001');
      
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });
    
    test('should return valid result for valid RUC Public Society', () {
      final result = RucValidator.validateRuc('1760004650001');
      
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });
    
    test('should return invalid result for invalid RUC', () {
      final result = RucValidator.validateRuc('9999999999999');
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, isNotNull);
    });
    
    test('should return invalid result for empty RUC', () {
      final result = RucValidator.validateRuc('');
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Identification cannot be empty');
      expect(result.typeCodeError, ErrorCode.invalidEmpty);
    });
    
    test('should return invalid result for incorrectly formatted RUC', () {
      final result = RucValidator.validateRuc('123ABC456789');
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Invalid identification: must be exactly 13 digits and contain only numbers.');
      expect(result.typeCodeError, ErrorCode.invalidLengthOrFormat);
    });
  });
}