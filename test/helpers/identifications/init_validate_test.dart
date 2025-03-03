import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';

void main() {
  group('initValidate Tests', () {
    test('Should throw exception if identification is empty', () {
      expect( 
        () => initValidate( '', TypeIdentification.dni ), 
        throwsA(
          allOf(
            isA<IdentificationException>(),
            predicate( (IdentificationException e) =>
              e.code == ErrorCode.invalidEmpty
              && e.message == 'Identification cannot be empty'
            )
          )
        )
      );
    });
    
    test('should trigger error when identification contains only whitespace', () {
      const messageError = 'Identification cannot be empty';
      
      expect(
        () => initValidate('   ', TypeIdentification.dni),
        throwsA(
          allOf(
            isA<IdentificationException>(),
            predicate((e) => (e as IdentificationException).message == messageError && 
                              e.code == ErrorCode.invalidEmpty)
          )
        )
      );
    });

    test('should trigger error when dni format is invalid', () {
      const messageError = 'Invalid identification: must be exactly 10 digits and contain only numbers.';
      
      expect(
        () => initValidate('123456789A', TypeIdentification.dni),
        throwsA(
          allOf(
            isA<IdentificationException>(),
            predicate((e) => (e as IdentificationException).message == messageError && 
                              e.code == ErrorCode.invalidLengthOrFormat)
          )
        )
      );
      
      expect(
        () => initValidate('12345', TypeIdentification.dni),
        throwsA(
          allOf(
            isA<IdentificationException>(),
            predicate((e) => (e as IdentificationException).message == messageError && 
                              e.code == ErrorCode.invalidLengthOrFormat)
          )
        )
      );
    });
  
    test('should trigger error when ruc format is invalid', () {
      const messageError = 'Invalid identification: must be exactly 13 digits and contain only numbers.';
      
      expect(
        () => initValidate('12345678901AB', TypeIdentification.ruc),
        throwsA(
          allOf(
            isA<IdentificationException>(),
            predicate((e) => (e as IdentificationException).message == messageError && 
                              e.code == ErrorCode.invalidLengthOrFormat)
          )
        )
      );
      
      expect(
        () => initValidate('12345', TypeIdentification.ruc),
        throwsA(
          allOf(
            isA<IdentificationException>(),
            predicate((e) => (e as IdentificationException).message == messageError && 
                              e.code == ErrorCode.invalidLengthOrFormat)
          )
        )
      );
    });

    test('should not throw error when dni format is valid', () {
      expect(() => initValidate('0105566046', TypeIdentification.dni), returnsNormally);
    });

    test('should not throw error when ruc format is valid', () {
      expect(() => initValidate('0105566046001', TypeIdentification.ruc), returnsNormally);
      expect(() => initValidate('1234567890123', TypeIdentification.rucPersonNatural), returnsNormally);
      expect(() => initValidate('1234567890123', TypeIdentification.rucPublicSociety), returnsNormally);
      expect(() => initValidate('1234567890123', TypeIdentification.rucSocietyPrivate), returnsNormally);
    });
  });
}