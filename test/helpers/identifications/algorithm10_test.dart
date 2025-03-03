import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

void main() {
  group('Algorithms10 tests', () {
    test('Should return a exception if the verification digit is empty', () {
      expect(
        () => algorithm10('010556604', ''), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit: must be a number.'
            )
          )
        )
      );
    });
    test('Should return a exception if the verification digit is not a number', () {
      expect(
        () => algorithm10('010556604', 'a'), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit: must be a number.'
            )
          )
        )
      );
    });
    
    test('Should return a exception if the firstDigits is not a numbers', () {
      expect(
        () => algorithm10('0105A6604', '6'), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidIdentification
              && e.message == 'Invalid identification: must be a number.'
            )
          )
        )
      );
    });

    test('Should return a exception if the verification digit is invalid', () {
      expect(
        () => algorithm10('010556604', '7'), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit.'
            )
          )
        )
      );
    });

    test('Should return true if the verification digit is valid', () {
      final result = algorithm10('010556604', '6');
      expect(
        result,
        true
      );
    });
  });
}