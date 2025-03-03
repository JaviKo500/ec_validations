import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/helpers/index.dart';

void main() {
  group('Validate third digit Tests', () {
    test('Should throw exception if third digit is empty', () {
      expect( () {
        validateThirdDigit('', TypeIdentification.dni);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number.'
          )
        )
      ));
    });

    test('Should throw exception if third digit is not a number', () {
      expect( () {
        validateThirdDigit('abc', TypeIdentification.dni);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number.'
          )
        )
      ));
    });

    test('Should throw exception if third digit of dni is less than 0 or greater than 5', () {
      expect( () {
        validateThirdDigit('-1', TypeIdentification.dni);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number between 0 and 5.'
          )
        )
      ));

      expect( () {
        validateThirdDigit('6', TypeIdentification.dni);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number between 0 and 5.'
          )
        )
      ));
    });

    test('Should throw exception if third digit of rucPersonNatural is less to 0 or greater than 5', () {
      expect( () {
        validateThirdDigit('-1', TypeIdentification.rucPersonNatural);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number between 0 and 5.'
          )
        )
      ));

      expect( () {
        validateThirdDigit('6', TypeIdentification.rucPersonNatural);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number between 0 and 5.'
          )
        )
      ));
    });

    test('Should not throw exception if third digit is valid for dni', () {
      expect( () {
        validateThirdDigit('1', TypeIdentification.dni);
      }, returnsNormally);
    });

    test('Should not throw exception if third digit is valid for rucPersonNatural', () {
      expect( () {
        validateThirdDigit('1', TypeIdentification.rucPersonNatural);
      }, returnsNormally);
    });

    test('Should throw exception if third digit is invalid for rucSocietyPrivate', () {
      expect( () {
        validateThirdDigit('5', TypeIdentification.rucSocietyPrivate);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number equal to 9.'
          )
        )
      ));
    });

    test('Should throw exception if third digit is invalid for rucPublicSociety', () {
      expect( () {
        validateThirdDigit('5', TypeIdentification.rucPublicSociety);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidThirdDigit
            && e.message == 'Invalid third digit: must be a number equal to 6.'
          )
        )
      ));
    });

    test('Should not throw exception if third digit is valid for rucSocietyPrivate', () {
      expect( () {
        validateThirdDigit('9', TypeIdentification.rucSocietyPrivate);
      }, returnsNormally);
    });
    test('Should not throw exception if third digit is valid for rucPublicSociety', () {
      expect( () {
        validateThirdDigit('6', TypeIdentification.rucPublicSociety);
      }, returnsNormally);
    });

    test('Should throw exception if type identification is invalid', () {
      expect( () {
        validateThirdDigit('1', TypeIdentification.ruc);
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidType
            && e.message == 'Invalid identification type'
          )
        )
      ));
    });
  });
}