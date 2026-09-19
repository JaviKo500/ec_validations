import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

void main() {
  tearDown(() => EcValidationsL10n.use('en'));

  group('PhoneErrorCode Enum Tests', () {
    test('PhoneErrorCode should be correct values', () {
      expect(PhoneErrorCode.values.length, equals(5));
      expect(PhoneErrorCode.values.contains(PhoneErrorCode.invalidLength), isTrue);
      expect(PhoneErrorCode.values.contains(PhoneErrorCode.invalidFormat), isTrue);
      expect(PhoneErrorCode.values.contains(PhoneErrorCode.invalidCountryCode), isTrue);
      expect(PhoneErrorCode.values.contains(PhoneErrorCode.invalidEmpty), isTrue);
      expect(PhoneErrorCode.values.contains(PhoneErrorCode.invalidPhone), isTrue);
    });
  });

  group('PhoneResult Tests', () {
    test('Should create a valid result with no error', () {
      final result = PhoneResult(isValid: true, normalizedNumber: '0991234567');

      expect(result.isValid, isTrue);
      expect(result.normalizedNumber, equals('0991234567'));
      expect(result.errorMessage, isNull);
      expect(result.typeCodeError, isNull);
      expect(result.messageKey, isNull);
      expect(result.messageArgs, isEmpty);
    });

    test('Should create an invalid result from a message key', () {
      final result = PhoneResult(
        isValid: false,
        typeCodeError: PhoneErrorCode.invalidEmpty,
        messageKey: EcMessageKey.phoneEmpty,
      );

      expect(result.isValid, isFalse);
      expect(result.normalizedNumber, isNull);
      expect(result.typeCodeError, equals(PhoneErrorCode.invalidEmpty));
      expect(result.errorMessage, equals('Phone number cannot be empty.'));
    });

    test('Should build the message with the arguments it carries', () {
      final result = PhoneResult(
        isValid: false,
        typeCodeError: PhoneErrorCode.invalidCountryCode,
        messageKey: EcMessageKey.phoneCountryCode,
        messageArgs: const {'countryCode': '+000'},
      );

      expect(result.messageArgs, equals({'countryCode': '+000'}));
      expect(result.errorMessage, contains('+000'));
    });

    test('Should resolve the message with the locale in use', () {
      final result = PhoneResult(
        isValid: false,
        messageKey: EcMessageKey.phoneEmpty,
      );

      expect(result.errorMessage, equals('Phone number cannot be empty.'));

      EcValidationsL10n.use('es');

      expect(result.errorMessage, equals('El número de teléfono no puede estar vacío.'));
    });

    test('Should resolve the message in the requested locale', () {
      final result = PhoneResult(
        isValid: false,
        messageKey: EcMessageKey.phoneEmpty,
      );

      expect(result.messageIn(EcMessagesEn()), equals('Phone number cannot be empty.'));
      expect(
        result.messageIn(EcMessagesEs()),
        equals('El número de teléfono no puede estar vacío.'),
      );
    });

    test('Should prefer an explicit message over the key', () {
      final result = PhoneResult(
        isValid: false,
        errorMessage: 'Custom message',
        typeCodeError: PhoneErrorCode.invalidPhone,
        messageKey: EcMessageKey.phoneEmpty,
      );

      expect(result.errorMessage, equals('Custom message'));

      EcValidationsL10n.use('es');

      expect(result.errorMessage, equals('Custom message'));
    });

    test('Should keep an explicit message out of messageIn when a key is set', () {
      final result = PhoneResult(
        isValid: false,
        errorMessage: 'Custom message',
        messageKey: EcMessageKey.phoneEmpty,
      );

      expect(
        result.messageIn(EcMessagesEs()),
        equals('El número de teléfono no puede estar vacío.'),
      );
    });

    test('Should return the explicit message from messageIn without a key', () {
      final result = PhoneResult(isValid: false, errorMessage: 'Custom message');

      expect(result.messageIn(EcMessagesEs()), equals('Custom message'));
    });

    test('Should return null when there is neither a message nor a key', () {
      final result = PhoneResult(isValid: false);

      expect(result.errorMessage, isNull);
      expect(result.messageIn(EcMessagesEs()), isNull);
    });
  });
}
