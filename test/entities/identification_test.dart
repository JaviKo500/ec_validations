import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';

void main() {
  group('TypeIdentification Enum Tests', () {
    test('TypeIdentification should be correct values ', () {
      expect( TypeIdentification.values.length , equals(5));
      expect(TypeIdentification.values.contains(TypeIdentification.dni), isTrue);
      expect(TypeIdentification.values.contains(TypeIdentification.ruc), isTrue);
      expect(TypeIdentification.values.contains(TypeIdentification.rucPersonNatural), isTrue);
      expect(TypeIdentification.values.contains(TypeIdentification.rucPublicSociety), isTrue);
      expect(TypeIdentification.values.contains(TypeIdentification.rucSocietyPrivate), isTrue);
    });
  });

  group('IdentificationResult Tests', () {
    test('Should create valid result with no error', (){
      final result = IdentificationResult(isValid: true);
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
    });

    test('Should create invalid result with error', (){

      const errorCode = ErrorCode.invalidType;
      const errorMessage = 'Invalid identification type';

      final result = IdentificationResult(isValid: false, errorMessage: errorMessage, typeCodeError: errorCode);

      expect(result.isValid, isFalse);
      expect(result.errorMessage, equals(errorMessage));
      expect(result.typeCodeError, equals(errorCode));
    });
  });

  group('ErrorCode Enum Tests', () {
    test('ErrorCode should be correct values ', () {
      expect( ErrorCode.values.length , equals(9));
      expect(ErrorCode.values.contains(ErrorCode.invalidIdentification), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidThirdDigit), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidVerificationDigit), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidCodeEstablishment), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidEmpty), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidLengthOrFormat), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidCodeProvince), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidType), isTrue);
      expect(ErrorCode.values.contains(ErrorCode.invalidCheckDigit), isTrue);
    });
  });

  group('ValidationRule Tests', (){
    test('Should create ValidationRule with pattern and error message', (){
      const pattern = r'^\d{10}$';
      const errorMessage = 'Dni required 10 digits and only numbers';
      
      final rule = ValidationRule(
        pattern: pattern,
        errorMessage: errorMessage,
      );
      
      expect(rule.pattern, equals(pattern));
      expect(rule.errorMessage, equals(errorMessage));
    });
  });
}