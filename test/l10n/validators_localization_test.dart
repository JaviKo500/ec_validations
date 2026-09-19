import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

/// Every validator resolves its message through the selected locale, and does
/// it when the message is read, not when the value is validated.
void main() {
  tearDown(() => EcValidationsL10n.use('en'));

  group('DniValidator localization Tests', () {
    test('Should report an empty identification in Spanish', () {
      EcValidationsL10n.use('es');

      final result = DniValidator.isValid('');

      expect(result.typeCodeError, equals(ErrorCode.invalidEmpty));
      expect(result.errorMessage, equals('La identificación no puede estar vacía'));
    });

    test('Should report the length in Spanish with the expected digits', () {
      EcValidationsL10n.use('es');

      final result = DniValidator.isValid('123456789');

      expect(result.typeCodeError, equals(ErrorCode.invalidLengthOrFormat));
      expect(
        result.errorMessage,
        equals('Identificación inválida: debe tener exactamente 10 dígitos y '
            'contener solo números.'),
      );
    });

    test('Should report every failure in Spanish', () {
      EcValidationsL10n.use('es');

      final results = <String, IdentificationResult>{
        'province': DniValidator.isValid('3305566046'),
        'checkDigit': DniValidator.isValid('0105566047'),
      };

      for (final entry in results.entries) {
        expect(entry.value.isValid, isFalse, reason: entry.key);
        expect(
          entry.value.errorMessage,
          isNot(equals(entry.value.messageIn(EcMessagesEn()))),
          reason: entry.key,
        );
      }
    });

    test('Should keep the message null when the identification is valid', () {
      EcValidationsL10n.use('es');

      final result = DniValidator.isValid('0105566046');

      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.messageIn(EcMessagesEs()), isNull);
    });
  });

  group('RucValidator localization Tests', () {
    test('Should report validateRucByType failures in Spanish', () {
      EcValidationsL10n.use('es');

      final result = RucValidator.validateRucByType(
        '0105566046',
        TypeIdentification.rucPersonNatural,
      );

      expect(result.typeCodeError, equals(ErrorCode.invalidLengthOrFormat));
      expect(
        result.errorMessage,
        equals('Identificación inválida: debe tener exactamente 13 dígitos y '
            'contener solo números.'),
      );
    });

    test('Should report an invalid type in Spanish', () {
      EcValidationsL10n.use('es');

      final result = RucValidator.validateRucByType(
        '0105566046001',
        TypeIdentification.ruc,
      );

      expect(result.typeCodeError, equals(ErrorCode.invalidType));
      expect(result.errorMessage, equals('Tipo de identificación inválido'));
    });

    test('Should report validateRuc failures in Spanish', () {
      EcValidationsL10n.use('es');

      final result = RucValidator.validateRuc('');

      expect(result.typeCodeError, equals(ErrorCode.invalidEmpty));
      expect(result.errorMessage, equals('La identificación no puede estar vacía'));
    });

    test('Should report isPossiblyValidRuc failures in Spanish', () {
      EcValidationsL10n.use('es');

      final result = RucValidator.isPossiblyValidRuc('3391034039001');

      expect(result.typeCodeError, equals(ErrorCode.invalidCodeProvince));
      expect(
        result.errorMessage,
        equals('Código de provincia inválido: los dos primeros dígitos deben '
            'ser un número entre 00 y 24.'),
      );
    });

    test('Should keep the arguments of the failure it reports', () {
      final result = RucValidator.validateRuc('123ABC456789');

      expect(result.messageKey, equals(EcMessageKey.identificationLengthOrFormat));
      expect(result.messageArgs, equals({'digits': 13}));
      expect(result.messageIn(EcMessagesEs()), contains('13'));
    });
  });

  group('PhoneValidator localization Tests', () {
    test('Should report an empty phone number in Spanish', () {
      EcValidationsL10n.use('es');

      final result = PhoneValidator.isValidLocal('');

      expect(result.typeCodeError, equals(PhoneErrorCode.invalidEmpty));
      expect(result.errorMessage, equals('El número de teléfono no puede estar vacío.'));
    });

    test('Should report a wrong country code in Spanish', () {
      EcValidationsL10n.use('es');

      final result = PhoneValidator.isValidInternational('+1991234567');

      expect(result.typeCodeError, equals(PhoneErrorCode.invalidCountryCode));
      expect(
        result.errorMessage,
        equals('El número de teléfono debe empezar con el código de país de '
            'Ecuador +593.'),
      );
    });

    test('Should report a wrong local prefix in Spanish', () {
      EcValidationsL10n.use('es');

      final result = PhoneValidator.isValid('0891234567');

      expect(result.typeCodeError, equals(PhoneErrorCode.invalidFormat));
      expect(
        result.errorMessage,
        equals('El número de teléfono debe empezar con 09 para un celular o '
            'con 02 a 07 para un teléfono fijo.'),
      );
    });

    test('Should report an international length in Spanish', () {
      EcValidationsL10n.use('es');

      final result = PhoneValidator.isValidInternational('+5939912345');

      expect(result.typeCodeError, equals(PhoneErrorCode.invalidLength));
      expect(
        result.errorMessage,
        equals('El número de teléfono debe tener exactamente 9 dígitos '
            'después de +593 para un celular u 8 para un teléfono fijo.'),
      );
    });

    test('Should report an international prefix in Spanish', () {
      EcValidationsL10n.use('es');

      final result = PhoneValidator.isValidInternational('+593891234567');

      expect(result.typeCodeError, equals(PhoneErrorCode.invalidFormat));
      expect(
        result.errorMessage,
        equals('El número de teléfono debe continuar con 9 para un celular o '
            'con 2 a 7 para un teléfono fijo después de +593.'),
      );
    });

    test('Should keep the message null when the number is valid', () {
      EcValidationsL10n.use('es');

      final result = PhoneValidator.isValid('0991234567');

      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
      expect(result.normalizedNumber, equals('0991234567'));
    });
  });

  group('Validation result late binding Tests', () {
    test('Should resolve the identification message when it is read', () {
      EcValidationsL10n.use('en');
      final result = DniValidator.isValid('');
      expect(result.errorMessage, equals('Identification cannot be empty'));

      EcValidationsL10n.use('es');

      expect(result.errorMessage, equals('La identificación no puede estar vacía'));
    });

    test('Should resolve the phone message when it is read', () {
      EcValidationsL10n.use('en');
      final result = PhoneValidator.isValidLocal('123');
      expect(
        result.errorMessage,
        equals('Phone number must be exactly 10 characters long for a mobile '
            'number or 9 for a landline number.'),
      );

      EcValidationsL10n.use('es');

      expect(
        result.errorMessage,
        equals('El número de teléfono debe tener exactamente 10 caracteres '
            'para un celular o 9 para un teléfono fijo.'),
      );
    });

    test('Should read a locale without changing the selected one', () {
      EcValidationsL10n.use('en');

      final dni = DniValidator.isValid('');
      final phone = PhoneValidator.isValidLocal('');

      expect(dni.messageIn(EcMessagesEs()), equals('La identificación no puede estar vacía'));
      expect(phone.messageIn(EcMessagesEs()), equals('El número de teléfono no puede estar vacío.'));
      expect(EcValidationsL10n.messages.localeCode, equals('en'));
      expect(dni.errorMessage, equals('Identification cannot be empty'));
      expect(phone.errorMessage, equals('Phone number cannot be empty.'));
    });
  });
}
