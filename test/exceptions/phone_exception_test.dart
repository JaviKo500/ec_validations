import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';
import 'package:ec_validations/exceptions/index.dart';

void main() {
  tearDown(() => EcValidationsL10n.use('en'));

  group('PhoneException Tests', () {
    test('Should create exception with code and key', () {
      final exception = PhoneException(
        PhoneErrorCode.invalidEmpty,
        EcMessageKey.phoneEmpty,
      );

      expect(exception.code, equals(PhoneErrorCode.invalidEmpty));
      expect(exception.key, equals(EcMessageKey.phoneEmpty));
      expect(exception.args, isEmpty);
      expect(exception.message, equals('Phone number cannot be empty.'));
    });

    test('Should build the message with the arguments it receives', () {
      final exception = PhoneException(
        PhoneErrorCode.invalidCountryCode,
        EcMessageKey.phoneCountryCode,
        const {'countryCode': '+000'},
      );

      expect(exception.args, equals({'countryCode': '+000'}));
      expect(exception.message, contains('+000'));
    });

    test('Should resolve the message with the locale in use', () {
      final exception = PhoneException(
        PhoneErrorCode.invalidEmpty,
        EcMessageKey.phoneEmpty,
      );

      expect(exception.message, equals('Phone number cannot be empty.'));

      EcValidationsL10n.use('es');

      expect(exception.message, equals('El número de teléfono no puede estar vacío.'));
    });

    test('Should describe itself with its code and message', () {
      final exception = PhoneException(
        PhoneErrorCode.invalidFormat,
        EcMessageKey.phoneLocalFormat,
      );

      expect(
        exception.toString(),
        equals('Error ${PhoneErrorCode.invalidFormat}: ${exception.message}'),
      );
      expect(exception.toString(), contains('invalidFormat'));
    });

    test('Should describe itself in the locale in use', () {
      final exception = PhoneException(
        PhoneErrorCode.invalidEmpty,
        EcMessageKey.phoneEmpty,
      );

      EcValidationsL10n.use('es');

      expect(exception.toString(), contains('El número de teléfono no puede estar vacío.'));
    });

    test('Should be catchable as Exception', () {
      expect(
        () => throw PhoneException(
          PhoneErrorCode.invalidPhone,
          EcMessageKey.phoneInvalid,
        ),
        throwsException,
      );
    });

    test('Should be catchable as PhoneException', () {
      expect(
        () => throw PhoneException(
          PhoneErrorCode.invalidPhone,
          EcMessageKey.phoneInvalid,
        ),
        throwsA(isA<PhoneException>()),
      );
    });
  });
}
