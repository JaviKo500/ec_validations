import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/identification.dart';
import 'package:ec_validations/exceptions/identification_exception.dart';
import 'package:ec_validations/helpers/identification/algorithm11.dart';

void main() {
  group('Algorithm11 tests', () {
    test('Should return a exception if the type identification is invalid', () {
      expect(
        () => algorithm11('010556604', '6', TypeIdentification.ruc), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidType
              && e.message == 'Invalid identification type'
            )
          )
        )
      );
    });

    test('Should return a exception if the type verification digit is invalid', () {
      expect(
        () => algorithm11('010556604', '', TypeIdentification.rucPublicSociety), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit: must be a number.',
            )
          )
        )
      );

      expect(
        () => algorithm11('010556604', 'A', TypeIdentification.rucPublicSociety), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit: must be a number.',
            )
          )
        )
      );
    });

    test('Should return error if initials digits length is not equal to coefficients length', () {
      expect(
        () => algorithm11('010556604', '6', TypeIdentification.rucPublicSociety), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidType
              && e.message == 'Invalid identification type'
            )
          )
        )
      );
      expect(
        () => algorithm11('01055660', '6', TypeIdentification.rucSocietyPrivate), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidType
              && e.message == 'Invalid identification type'
            )
          )
        )
      );
    });
    
    test('Should return error if verification digit is invalid', () {
      expect(
        () => algorithm11('17600046', '6', TypeIdentification.rucPublicSociety), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit.',
            )
          )
        )
      );
      expect(
        () => algorithm11('179001167', '6', TypeIdentification.rucSocietyPrivate), 
        throwsA(allOf(
            isA<IdentificationException>(),
            predicate((IdentificationException e) => 
              e.code == ErrorCode.invalidVerificationDigit
              && e.message == 'Invalid verification digit.',
            )
          )
        )
      );
    });

    test('Should return true if verification digit is valid', () {
      final isValidRucPublicDigit = algorithm11('17600046', '5', TypeIdentification.rucPublicSociety);  
      final isValidRucPrivateDigit = algorithm11('179001167', '4', TypeIdentification.rucSocietyPrivate);
      expect(isValidRucPublicDigit, true);
      expect(isValidRucPrivateDigit, true);
    });
  });
}