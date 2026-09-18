import 'package:ec_validations/l10n/ec_validations_l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';

void main() {
  group('TypeIdentification Enum Tests', () {
    test('TypeIdentification should be correct values ', () {
      expect( TypeIdentification.values.length , equals(6));
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
      const errorMessage = 'Invalid identification: must be exactly 10 digits and contain only numbers.';
      final rule = ValidationRule.digits(10);
      expect(rule.pattern, equals(pattern));
      expect(rule.messageKey, equals(EcMessageKey.identificationLengthOrFormat));
      expect(rule.args, equals({'digits': 10}));
      expect(EcValidationsL10n.messages.message(rule.messageKey, rule.args), equals(errorMessage));
    });

    test('Should build the rule message with its own digits', (){
      final rule = ValidationRule.digits(13);

      expect(rule.pattern, equals(r'^\d{13}$'));
      expect(
        EcValidationsL10n.messages.message(rule.messageKey, rule.args),
        equals('Invalid identification: must be exactly 13 digits and contain only numbers.'),
      );
    });
  });
}
