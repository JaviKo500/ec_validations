import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

/// Selecting a locale changes static state shared by the whole package, so
/// every test restores English before the next one runs.
///
/// The catalogs registered by [EcValidationsL10n.register] live in the same
/// static state, so they are exercised in their own test file: a test file is
/// the isolation unit of `flutter test`.
void main() {
  group('EcValidationsL10n default Tests', () {
    test('Should use English before a locale is selected', () {
      expect(EcValidationsL10n.messages, isA<EcMessagesEn>());
      expect(EcValidationsL10n.messages.localeCode, equals('en'));
    });
  });

  group('EcValidationsL10n use Tests', () {
    tearDown(() => EcValidationsL10n.use('en'));

    test('Should select a shipped locale', () {
      expect(EcValidationsL10n.use('es'), isTrue);
      expect(EcValidationsL10n.messages, isA<EcMessagesEs>());
      expect(EcValidationsL10n.messages.localeCode, equals('es'));
    });

    test('Should select the locale already in use', () {
      EcValidationsL10n.use('es');

      expect(EcValidationsL10n.use('es'), isTrue);
      expect(EcValidationsL10n.messages.localeCode, equals('es'));
    });

    test('Should go back to English', () {
      EcValidationsL10n.use('es');

      expect(EcValidationsL10n.use('en'), isTrue);
      expect(EcValidationsL10n.messages, isA<EcMessagesEn>());
    });

    test('Should ignore the case of the locale code', () {
      for (final code in const ['ES', 'Es', 'eS']) {
        expect(EcValidationsL10n.use(code), isTrue, reason: code);
        expect(EcValidationsL10n.messages.localeCode, equals('es'),
            reason: code);
        EcValidationsL10n.use('en');
      }
    });

    test('Should ignore the spaces around the locale code', () {
      for (final code in const [' es', 'es ', '   es   ', '\tes\n']) {
        expect(EcValidationsL10n.use(code), isTrue, reason: '"$code"');
        expect(EcValidationsL10n.messages.localeCode, equals('es'),
            reason: '"$code"');
        EcValidationsL10n.use('en');
      }
    });

    test('Should resolve a locale code that carries a region', () {
      for (final code in const [
        'es-EC',
        'es_EC',
        'es-ec',
        'ES_ec',
        'es-419',
        ' es_EC ',
      ]) {
        expect(EcValidationsL10n.use(code), isTrue, reason: code);
        expect(EcValidationsL10n.messages.localeCode, equals('es'),
            reason: code);
        EcValidationsL10n.use('en');
      }
    });

    test('Should resolve a region of a locale written with a script', () {
      expect(EcValidationsL10n.use('es-Latn-EC'), isTrue);
      expect(EcValidationsL10n.messages.localeCode, equals('es'));
    });

    test('Should reject an unknown locale', () {
      EcValidationsL10n.use('es');

      expect(EcValidationsL10n.use('fr'), isFalse);
      expect(EcValidationsL10n.use('de-DE'), isFalse);
      expect(EcValidationsL10n.use('zz'), isFalse);
    });

    test('Should keep the current locale when the code is unknown', () {
      EcValidationsL10n.use('es');

      EcValidationsL10n.use('fr');

      expect(EcValidationsL10n.messages, isA<EcMessagesEs>());
      expect(EcValidationsL10n.messages.localeCode, equals('es'));
    });

    test('Should reject an empty or blank locale code', () {
      for (final code in const ['', ' ', '   ', '\t', '\n']) {
        expect(EcValidationsL10n.use(code), isFalse, reason: '"$code"');
      }
      expect(EcValidationsL10n.messages.localeCode, equals('en'));
    });

    test('Should reject a locale code made only of separators', () {
      for (final code in const ['-', '_', '--', '-EC', '_EC']) {
        expect(EcValidationsL10n.use(code), isFalse, reason: code);
      }
      expect(EcValidationsL10n.messages.localeCode, equals('en'));
    });

    test('Should not match a locale code by prefix', () {
      for (final code in const ['e', 'es2', 'esp', 'english', 'spanish']) {
        expect(EcValidationsL10n.use(code), isFalse, reason: code);
      }
      expect(EcValidationsL10n.messages.localeCode, equals('en'));
    });

    test('Should return the messages of the selected locale', () {
      EcValidationsL10n.use('es');

      expect(
        EcValidationsL10n.messages.message(EcMessageKey.identificationEmpty),
        equals('La identificación no puede estar vacía'),
      );

      EcValidationsL10n.use('en');

      expect(
        EcValidationsL10n.messages.message(EcMessageKey.identificationEmpty),
        equals('Identification cannot be empty'),
      );
    });
  });
}
