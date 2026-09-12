import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validateInternationalPhone valid numbers', (){
    test('return a valid number phone', (){
      expect(validateInternationalPhone('+593991234567'), '+593991234567');
      expect(validateInternationalPhone('00593991234567'), '+593991234567');
      expect(validateInternationalPhone('593991234567'), '+593991234567');
      expect(validateInternationalPhone('+593 (0)99 123 4567'), '+593991234567');
    });
  });

  group('validateInternationalPhone return exceptions', (){
    test('return invalid empty exception', (){
      expect(
        () => validateInternationalPhone(''), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidEmpty )
          )
        ) 
      );
    });
    test('return invalid country code exception', (){
      expect(
        () => validateInternationalPhone('+1991234567'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidCountryCode )
          )
        ) 
      );
      expect(
        () => validateInternationalPhone('0991234567'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidCountryCode )
          )
        ) 
      );
    });
    test('return invalid format exception', (){
      expect(
        () => validateInternationalPhone('+593891234567'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        ) 
      );
    });
    test('return invalid length exception', (){
      expect(
        () => validateInternationalPhone('+59399123'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength )
          )
        ) 
      );
    });
  });
}