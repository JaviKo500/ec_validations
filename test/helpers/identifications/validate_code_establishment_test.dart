import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

void main() {
  group('Validate code establishment Tests', () { 
    test('Should throw exception if code establishment is empty', () {
      expect( () {
        validateCodeEstablishment('');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeEstablishment
            && e.message == 'Invalid code establishment: must be a number.'
          )
        )
      ));
    });

    test('Should throw exception if code establishment is not a number', () {
      expect( () {
        validateCodeEstablishment('abc');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeEstablishment
            && e.message == 'Invalid code establishment: must be a number.'
          )
        )
      ));
    });

    test('Should throw exception if code establishment is less than 0', () {
      expect( () {
        validateCodeEstablishment('-1');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeEstablishment
            && e.message == 'Invalid code establishment: must be a number greater than 0.'
          )
        )
      ));
    });

    test('Should not throw exception if code establishment is valid', () {
      expect( () {
        validateCodeEstablishment('1');
      }, returnsNormally);
    });
  });
}