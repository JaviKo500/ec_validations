import 'package:ec_validations/helpers/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizePhone', () {
    test('returns empty string for empty input', () {
      expect(normalizePhone(''), '');
    });

    test('returns the same number for a valid input', () {
      expect(normalizePhone('0991234567'), '0991234567');
      expect(normalizePhone('+593991234567'), '+593991234567');
    });

    test('returns the number without spaces', () {
      expect(normalizePhone('099 123 4567'), '0991234567');
    });

    test('returns the number without dots', () {
      expect(normalizePhone('099.123.4567'), '0991234567');
    });

    test('returns the number without dashes', () {
      expect(normalizePhone('099-123-4567'), '0991234567');
    });

    test('returns the number without parentheses', () {
      expect(normalizePhone('(099) 123-4567'), '0991234567');
    });

    test('returns the number without leading or trailing spaces', () {
      expect(normalizePhone(' 0991234567 '), '0991234567');
    });

    test('returns the number with a leading plus sign', () {
      expect(normalizePhone('00593991234567'), '+593991234567');
      expect(normalizePhone('593991234567'), '+593991234567');
    });

    test('returns the number equal to the expected value', () {
      expect(normalizePhone('+5930991234567'), '+593991234567');
    });

    test('returns the number when it has parentheses and without spaces', () {
      expect(normalizePhone('+593 (0)99 123 4567'), '+593991234567');
    });

    test('returns the input string if it contains non-numeric characters', () {
      expect(normalizePhone('abc'), 'abc');
    });

    test('returns the input string if it is already normalized', () {
      expect(normalizePhone('0891234567'), '0891234567');
    });
  });
}