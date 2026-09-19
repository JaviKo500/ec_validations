import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

/// The custom catalog documented in the Localization section of the README.
///
/// It rewords two messages and delegates the rest to the shipped catalog.
class _MyMessagesEn implements EcValidationsMessages {
  @override
  String get localeCode => 'en';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) {
    switch (key) {
      case EcMessageKey.identificationEmpty:
        return 'Please enter your ID number';
      case EcMessageKey.identificationLengthOrFormat:
        return 'It must have ${args['digits']} digits';
      default:
        return EcMessagesEn().message(key, args);
    }
  }
}

/// Keeps the examples of the README working.
///
/// Registering a catalog writes to static state shared by the whole package,
/// so these examples run in their own test file.
void main() {
  group('README localization examples Tests', () {
    tearDown(() {
      EcValidationsL10n.register(EcMessagesEn());
      EcValidationsL10n.use('en');
    });

    test('Should report the validation in the selected locale', () {
      EcValidationsL10n.use('es');

      final result = DniValidator.isValid('');

      expect(result.errorMessage, equals('La identificación no puede estar vacía'));
    });

    test('Should resolve every locale code the README lists', () {
      for (final code in const ['es', 'ES', 'es-EC', 'es_EC', 'es-419']) {
        expect(EcValidationsL10n.use(code), isTrue, reason: code);
        expect(EcValidationsL10n.messages, isA<EcMessagesEs>(), reason: code);
        EcValidationsL10n.use('en');
      }
    });

    test('Should read a locale with messageIn without selecting it', () {
      final result = PhoneValidator.isValid('0891234567');

      expect(
        result.messageIn(EcMessagesEs()),
        equals('El número de teléfono debe empezar con 09 para un celular o '
            'con 02 a 07 para un teléfono fijo.'),
      );
      expect(EcValidationsL10n.messages.localeCode, equals('en'));
    });

    test('Should use the reworded messages of a registered catalog', () {
      EcValidationsL10n.register(_MyMessagesEn());
      EcValidationsL10n.use('en');

      expect(
        DniValidator.isValid('').errorMessage,
        equals('Please enter your ID number'),
      );
      expect(
        DniValidator.isValid('123').errorMessage,
        equals('It must have 10 digits'),
      );
      expect(
        RucValidator.validateRuc('123').errorMessage,
        equals('It must have 13 digits'),
      );
    });

    test('Should fall through to the shipped catalog for untouched keys', () {
      EcValidationsL10n.register(_MyMessagesEn());
      EcValidationsL10n.use('en');

      expect(
        PhoneValidator.isValidLocal('').errorMessage,
        equals('Phone number cannot be empty.'),
      );
    });
  });
}
