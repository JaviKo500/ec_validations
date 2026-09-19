import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

/// Every message the English catalog emits, with the default arguments.
///
/// The map is compared against [EcMessageKey.values], so a new key fails this
/// test until it is translated here and in [_spanish].
const Map<EcMessageKey, String> _english = {
  EcMessageKey.identificationEmpty: 'Identification cannot be empty',
  EcMessageKey.identificationInvalidType: 'Invalid identification type',
  EcMessageKey.identificationInvalid: 'Invalid identification',
  EcMessageKey.identificationNotNumber:
      'Invalid identification: must be a number.',
  EcMessageKey.identificationLengthOrFormat:
      'Invalid identification: must be exactly 10 digits and contain only '
          'numbers.',
  EcMessageKey.verificationDigitNotNumber:
      'Invalid verification digit: must be a number.',
  EcMessageKey.verificationDigitInvalid: 'Invalid verification digit.',
  EcMessageKey.codeEstablishmentNotNumber:
      'Invalid code establishment: must be a number.',
  EcMessageKey.codeEstablishmentZero:
      'Invalid code establishment: must be a number greater than 0.',
  EcMessageKey.codeProvinceInvalid:
      'Invalid province code: the first two digits must be a number between '
          '00 and 24.',
  EcMessageKey.thirdDigitNotNumber: 'Invalid third digit: must be a number.',
  EcMessageKey.thirdDigitOutOfRange:
      'Invalid third digit: must be a number between 0 and 9.',
  EcMessageKey.thirdDigitMustBeNine:
      'Invalid third digit: must be a number equal to 9.',
  EcMessageKey.thirdDigitMustBeSix:
      'Invalid third digit: must be a number equal to 6.',
  EcMessageKey.rucInvalid: 'Invalid ruc identification',
  EcMessageKey.phoneEmpty: 'Phone number cannot be empty.',
  EcMessageKey.phoneInvalid: 'Invalid phone number',
  EcMessageKey.phoneLocalLength:
      'Phone number must be exactly 10 characters long for a mobile number or '
          '9 for a landline number.',
  EcMessageKey.phoneLocalFormat:
      'Phone number must start with 09 for a mobile number or with 02 to 07 '
          'for a landline number.',
  EcMessageKey.phoneCountryCode:
      'Phone number must start with the Ecuador country code +593.',
  EcMessageKey.phoneInternationalLength:
      'Phone number must have exactly 9 digits after +593 for a mobile number '
          'or 8 for a landline number.',
  EcMessageKey.phoneInternationalFormat:
      'Phone number must continue with 9 for a mobile number or with 2 to 7 '
          'for a landline number after +593.',
};

/// Every message the Spanish catalog emits, with the default arguments.
const Map<EcMessageKey, String> _spanish = {
  EcMessageKey.identificationEmpty: 'La identificación no puede estar vacía',
  EcMessageKey.identificationInvalidType: 'Tipo de identificación inválido',
  EcMessageKey.identificationInvalid: 'Identificación inválida',
  EcMessageKey.identificationNotNumber:
      'Identificación inválida: debe ser un número.',
  EcMessageKey.identificationLengthOrFormat:
      'Identificación inválida: debe tener exactamente 10 dígitos y contener '
          'solo números.',
  EcMessageKey.verificationDigitNotNumber:
      'Dígito verificador inválido: debe ser un número.',
  EcMessageKey.verificationDigitInvalid: 'Dígito verificador inválido.',
  EcMessageKey.codeEstablishmentNotNumber:
      'Código de establecimiento inválido: debe ser un número.',
  EcMessageKey.codeEstablishmentZero:
      'Código de establecimiento inválido: debe ser un número mayor a 0.',
  EcMessageKey.codeProvinceInvalid:
      'Código de provincia inválido: los dos primeros dígitos deben ser un '
          'número entre 00 y 24.',
  EcMessageKey.thirdDigitNotNumber: 'Tercer dígito inválido: debe ser un '
      'número.',
  EcMessageKey.thirdDigitOutOfRange:
      'Tercer dígito inválido: debe ser un número entre 0 y 9.',
  EcMessageKey.thirdDigitMustBeNine:
      'Tercer dígito inválido: debe ser un número igual a 9.',
  EcMessageKey.thirdDigitMustBeSix:
      'Tercer dígito inválido: debe ser un número igual a 6.',
  EcMessageKey.rucInvalid: 'RUC inválido',
  EcMessageKey.phoneEmpty: 'El número de teléfono no puede estar vacío.',
  EcMessageKey.phoneInvalid: 'Número de teléfono inválido',
  EcMessageKey.phoneLocalLength:
      'El número de teléfono debe tener exactamente 10 caracteres para un '
          'celular o 9 para un teléfono fijo.',
  EcMessageKey.phoneLocalFormat:
      'El número de teléfono debe empezar con 09 para un celular o con 02 a '
          '07 para un teléfono fijo.',
  EcMessageKey.phoneCountryCode:
      'El número de teléfono debe empezar con el código de país de Ecuador '
          '+593.',
  EcMessageKey.phoneInternationalLength:
      'El número de teléfono debe tener exactamente 9 dígitos después de +593 '
          'para un celular u 8 para un teléfono fijo.',
  EcMessageKey.phoneInternationalFormat:
      'El número de teléfono debe continuar con 9 para un celular o con 2 a 7 '
          'para un teléfono fijo después de +593.',
};

/// The keys whose message is built from an argument, with a value that is not
/// the default one so the interpolation is visible.
const Map<EcMessageKey, Map<String, Object?>> _keysWithArgs = {
  EcMessageKey.identificationLengthOrFormat: {'digits': 13},
  EcMessageKey.phoneCountryCode: {'countryCode': '+000'},
  EcMessageKey.phoneInternationalLength: {'countryCode': '+000'},
  EcMessageKey.phoneInternationalFormat: {'countryCode': '+000'},
};

void main() {
  final catalogs = <String, EcValidationsMessages>{
    'en': EcMessagesEn(),
    'es': EcMessagesEs(),
  };

  final goldens = <String, Map<EcMessageKey, String>>{
    'en': _english,
    'es': _spanish,
  };

  group('EcMessageKey Tests', () {
    test('Should expose every key the package can emit', () {
      expect(EcMessageKey.values.length, equals(22));
    });
  });

  for (final entry in catalogs.entries) {
    final locale = entry.key;
    final catalog = entry.value;
    final golden = goldens[locale]!;

    group('EcValidationsMessages $locale Tests', () {
      test('Should declare its locale code', () {
        expect(catalog.localeCode, equals(locale));
      });

      test('Should translate every key of EcMessageKey', () {
        expect(golden.keys.toSet(), equals(EcMessageKey.values.toSet()));
      });

      test('Should return the expected message for every key', () {
        for (final key in EcMessageKey.values) {
          expect(catalog.message(key), equals(golden[key]), reason: '$key');
        }
      });

      test('Should never return an empty or untrimmed message', () {
        for (final key in EcMessageKey.values) {
          final message = catalog.message(key);
          expect(message, isNotEmpty, reason: '$key');
          expect(message, equals(message.trim()), reason: '$key');
        }
      });

      test('Should return a different message for every key', () {
        final messages = <String, EcMessageKey>{};
        for (final key in EcMessageKey.values) {
          final message = catalog.message(key);
          expect(
            messages.containsKey(message),
            isFalse,
            reason: '$key repeats the message of ${messages[message]}',
          );
          messages[message] = key;
        }
      });

      test('Should ignore arguments the message does not use', () {
        for (final key in EcMessageKey.values) {
          if (_keysWithArgs.containsKey(key)) continue;
          expect(
            catalog.message(key, const {'digits': 99, 'countryCode': '+000'}),
            equals(catalog.message(key)),
            reason: '$key',
          );
        }
      });

      test('Should build the message with the argument it receives', () {
        for (final entry in _keysWithArgs.entries) {
          final withArgs = catalog.message(entry.key, entry.value);
          expect(
            withArgs,
            isNot(equals(catalog.message(entry.key))),
            reason: '${entry.key} ignores ${entry.value}',
          );
          for (final value in entry.value.values) {
            expect(withArgs, contains('$value'), reason: '${entry.key}');
          }
        }
      });

      test('Should fall back to the default value of a missing argument', () {
        expect(
          catalog.message(EcMessageKey.identificationLengthOrFormat),
          contains('10'),
        );
        for (final key in const [
          EcMessageKey.phoneCountryCode,
          EcMessageKey.phoneInternationalLength,
          EcMessageKey.phoneInternationalFormat,
        ]) {
          expect(catalog.message(key), contains('+593'), reason: '$key');
        }
      });

      test('Should ignore an unrelated argument of an interpolated key', () {
        expect(
          catalog.message(
            EcMessageKey.identificationLengthOrFormat,
            const {'countryCode': '+000'},
          ),
          equals(catalog.message(EcMessageKey.identificationLengthOrFormat)),
        );
      });
    });
  }

  group('EcValidationsMessages catalog parity Tests', () {
    test('Should translate every key to a different text in each locale', () {
      for (final key in EcMessageKey.values) {
        expect(
          _spanish[key],
          isNot(equals(_english[key])),
          reason: '$key is not translated',
        );
      }
    });

    test('Should keep the arguments out of the translation', () {
      for (final entry in _keysWithArgs.entries) {
        for (final value in entry.value.values) {
          expect(
            EcMessagesEs().message(entry.key, entry.value),
            contains('$value'),
            reason: '${entry.key}',
          );
        }
      }
    });
  });
}
