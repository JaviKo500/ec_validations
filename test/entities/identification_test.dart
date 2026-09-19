import 'package:ec_validations/l10n/ec_validations_l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';

void main() {
  tearDown(() => EcValidationsL10n.use('en'));

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

  group('IdentificationResult localization Tests', () {
    test('Should create an invalid result from a message key', () {
      final result = IdentificationResult(
        isValid: false,
        typeCodeError: ErrorCode.invalidEmpty,
        messageKey: EcMessageKey.identificationEmpty,
      );

      expect(result.messageKey, equals(EcMessageKey.identificationEmpty));
      expect(result.messageArgs, isEmpty);
      expect(result.errorMessage, equals('Identification cannot be empty'));
    });

    test('Should build the message with the arguments it carries', () {
      final result = IdentificationResult(
        isValid: false,
        typeCodeError: ErrorCode.invalidLengthOrFormat,
        messageKey: EcMessageKey.identificationLengthOrFormat,
        messageArgs: const {'digits': 13},
      );

      expect(result.messageArgs, equals({'digits': 13}));
      expect(result.errorMessage, contains('13'));
    });

    test('Should resolve the message with the locale in use', () {
      final result = IdentificationResult(
        isValid: false,
        messageKey: EcMessageKey.identificationEmpty,
      );

      expect(result.errorMessage, equals('Identification cannot be empty'));

      EcValidationsL10n.use('es');

      expect(result.errorMessage, equals('La identificación no puede estar vacía'));
    });

    test('Should resolve the message in the requested locale', () {
      final result = IdentificationResult(
        isValid: false,
        messageKey: EcMessageKey.identificationEmpty,
      );

      expect(result.messageIn(EcMessagesEn()), equals('Identification cannot be empty'));
      expect(
        result.messageIn(EcMessagesEs()),
        equals('La identificación no puede estar vacía'),
      );
    });

    test('Should prefer an explicit message over the key', () {
      final result = IdentificationResult(
        isValid: false,
        errorMessage: 'Custom message',
        messageKey: EcMessageKey.identificationEmpty,
      );

      expect(result.errorMessage, equals('Custom message'));

      EcValidationsL10n.use('es');

      expect(result.errorMessage, equals('Custom message'));
    });

    test('Should keep an explicit message out of messageIn when a key is set', () {
      final result = IdentificationResult(
        isValid: false,
        errorMessage: 'Custom message',
        messageKey: EcMessageKey.identificationEmpty,
      );

      expect(
        result.messageIn(EcMessagesEs()),
        equals('La identificación no puede estar vacía'),
      );
    });

    test('Should return the explicit message from messageIn without a key', () {
      final result = IdentificationResult(isValid: false, errorMessage: 'Custom message');

      expect(result.messageIn(EcMessagesEs()), equals('Custom message'));
    });

    test('Should return null when there is neither a message nor a key', () {
      final result = IdentificationResult(isValid: false);

      expect(result.errorMessage, isNull);
      expect(result.messageIn(EcMessagesEs()), isNull);
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

    test('Should translate the rule message with the locale in use', (){
      final rule = ValidationRule.digits(13);

      EcValidationsL10n.use('es');

      expect(
        EcValidationsL10n.messages.message(rule.messageKey, rule.args),
        equals('Identificación inválida: debe tener exactamente 13 dígitos y contener solo números.'),
      );
    });

    test('Should default to no arguments', (){
      final rule = ValidationRule(
        pattern: r'^\d{10}$',
        messageKey: EcMessageKey.identificationInvalid,
      );

      expect(rule.args, isEmpty);
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
