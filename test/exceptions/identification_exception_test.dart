import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/l10n/ec_validations_l10n.dart';

void main() {
  tearDown(() => EcValidationsL10n.use('en'));

  group('IdentificationException Tests', () {
    test('Should create exception with code and message', () {
      const errorCode = ErrorCode.invalidType;
      
      final exception = IdentificationException(errorCode, EcMessageKey.identificationInvalidType,);

      expect(exception.code, equals(errorCode));
      expect(exception.key, equals(EcMessageKey.identificationInvalidType));
      expect(exception.message, equals('Invalid identification type'));
    });

    test('Should be catchable as Exception', () {
      const errorCode = ErrorCode.invalidType;
      expect( () {
        throw IdentificationException(errorCode, EcMessageKey.identificationInvalidType,);
      }, throwsException);
    },);

    test('Should be catchable as IdentificationException', () {
      expect(
        () => throw IdentificationException(
          ErrorCode.invalidEmpty,
          EcMessageKey.identificationEmpty,
        ),
        throwsA(isA<IdentificationException>()),
      );
    });

    test('Should default to no arguments', () {
      final exception = IdentificationException(
        ErrorCode.invalidEmpty,
        EcMessageKey.identificationEmpty,
      );

      expect(exception.args, isEmpty);
    });

    test('Should build the message with the arguments it receives', () {
      final exception = IdentificationException(
        ErrorCode.invalidLengthOrFormat,
        EcMessageKey.identificationLengthOrFormat,
        const {'digits': 13},
      );

      expect(exception.args, equals({'digits': 13}));
      expect(exception.message, contains('13'));
    });

    test('Should resolve the message with the locale in use', () {
      final exception = IdentificationException(
        ErrorCode.invalidEmpty,
        EcMessageKey.identificationEmpty,
      );

      expect(exception.message, equals('Identification cannot be empty'));

      EcValidationsL10n.use('es');

      expect(exception.message, equals('La identificación no puede estar vacía'));
    });

    test('Should describe itself with its code and message', () {
      final exception = IdentificationException(
        ErrorCode.invalidType,
        EcMessageKey.identificationInvalidType,
      );

      expect(
        exception.toString(),
        equals('Error ${ErrorCode.invalidType}: ${exception.message}'),
      );
      expect(exception.toString(), contains('invalidType'));
    });

    test('Should describe itself in the locale in use', () {
      final exception = IdentificationException(
        ErrorCode.invalidEmpty,
        EcMessageKey.identificationEmpty,
      );

      EcValidationsL10n.use('es');

      expect(exception.toString(), contains('La identificación no puede estar vacía'));
    });
  });
}