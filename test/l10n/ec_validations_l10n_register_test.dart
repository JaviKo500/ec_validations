import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

/// A catalog for a locale the package does not ship.
class _MessagesFr implements EcValidationsMessages {
  @override
  String get localeCode => 'fr';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) =>
      'fr:${key.name}';
}

/// A catalog declaring its locale the way a platform usually reports it: a
/// region, in upper case, joined with an underscore.
class _MessagesEsEc implements EcValidationsMessages {
  @override
  String get localeCode => 'es_EC';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) =>
      'es_EC:${key.name}';
}

/// A catalog replacing a locale the package ships.
class _MessagesEnCustom implements EcValidationsMessages {
  @override
  String get localeCode => 'en';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) =>
      'custom:${key.name}';
}

/// [EcValidationsL10n.register] writes to static state shared by the whole
/// package, so these tests live apart from the ones covering the shipped
/// locales: a test file is the isolation unit of `flutter test`.
void main() {
  const anyKey = EcMessageKey.identificationEmpty;

  tearDown(() {
    EcValidationsL10n.register(EcMessagesEn());
    EcValidationsL10n.use('en');
  });

  group('EcValidationsL10n register Tests', () {
    test('Should make a new locale selectable', () {
      expect(EcValidationsL10n.use('fr'), isFalse);

      EcValidationsL10n.register(_MessagesFr());

      expect(EcValidationsL10n.use('fr'), isTrue);
      expect(EcValidationsL10n.messages, isA<_MessagesFr>());
      expect(EcValidationsL10n.messages.message(anyKey), equals('fr:${anyKey.name}'));
    });

    test('Should not change the locale in use', () {
      EcValidationsL10n.use('es');

      EcValidationsL10n.register(_MessagesFr());

      expect(EcValidationsL10n.messages, isA<EcMessagesEs>());
    });

    test('Should register a new locale under a normalized code', () {
      EcValidationsL10n.register(_MessagesFr());

      for (final code in const ['FR', ' fr ', 'fr-CA', 'fr_CA']) {
        expect(EcValidationsL10n.use(code), isTrue, reason: code);
        expect(EcValidationsL10n.messages, isA<_MessagesFr>(), reason: code);
        EcValidationsL10n.use('en');
      }
    });

    test('Should reach a locale registered with a region by every notation', () {
      EcValidationsL10n.register(_MessagesEsEc());

      for (final code in const ['es_EC', 'es-EC', 'es-ec', 'ES_EC', ' es-EC ']) {
        expect(EcValidationsL10n.use(code), isTrue, reason: code);
        expect(EcValidationsL10n.messages, isA<_MessagesEsEc>(), reason: code);
        EcValidationsL10n.use('en');
      }
    });

    test('Should prefer a registered region over its language', () {
      EcValidationsL10n.register(_MessagesEsEc());

      expect(EcValidationsL10n.use('es-EC'), isTrue);
      expect(EcValidationsL10n.messages, isA<_MessagesEsEc>());

      expect(EcValidationsL10n.use('es'), isTrue);
      expect(EcValidationsL10n.messages, isA<EcMessagesEs>());
    });

    test('Should fall back to the language for an unregistered region', () {
      EcValidationsL10n.register(_MessagesEsEc());

      expect(EcValidationsL10n.use('es-PE'), isTrue);
      expect(EcValidationsL10n.messages, isA<EcMessagesEs>());
    });

    test('Should replace a locale the package ships', () {
      EcValidationsL10n.register(_MessagesEnCustom());

      expect(EcValidationsL10n.use('en'), isTrue);
      expect(EcValidationsL10n.messages, isA<_MessagesEnCustom>());
      expect(
        EcValidationsL10n.messages.message(anyKey),
        equals('custom:${anyKey.name}'),
      );
    });

    test('Should replace the messages a result reads', () {
      EcValidationsL10n.register(_MessagesFr());
      EcValidationsL10n.use('fr');

      final result = DniValidator.isValid('');

      expect(result.isValid, isFalse);
      expect(result.typeCodeError, equals(ErrorCode.invalidEmpty));
      expect(result.errorMessage, equals('fr:${anyKey.name}'));
    });

    test('Should keep the last catalog registered for the same locale', () {
      EcValidationsL10n.register(_MessagesFr());
      EcValidationsL10n.register(_MessagesFr());
      EcValidationsL10n.register(_MessagesEnCustom());

      expect(EcValidationsL10n.use('en'), isTrue);
      expect(EcValidationsL10n.messages, isA<_MessagesEnCustom>());
    });
  });
}
