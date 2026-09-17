import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';
import 'package:ec_validations/helpers/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validateInternationalLocalPhone valid numbers', (){
    test('return the number keeping the local notation', (){
      expect(validateInternationalLocalPhone('0991234567'), '0991234567');
      expect(validateInternationalLocalPhone('099 123 4567'), '0991234567');
      expect(validateInternationalLocalPhone(' 0991234567'), '0991234567');
      expect(validateInternationalLocalPhone('(099) 123-4567'), '0991234567');
    });

    test('return the number keeping the international notation', (){
      expect(validateInternationalLocalPhone('+593991234567'), '+593991234567');
      expect(validateInternationalLocalPhone('00593991234567'), '+593991234567');
      expect(validateInternationalLocalPhone('593991234567'), '+593991234567');
      expect(validateInternationalLocalPhone('+593 (0)99 123 4567'), '+593991234567');
    });
  });

  group('validateInternationalLocalPhone return exceptions', (){
    test('return invalid empty exception', (){
      expect(
        () => validateInternationalLocalPhone(''), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidEmpty )
          )
        ) 
      );
      expect(
        () => validateInternationalLocalPhone('   '), 
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
        () => validateInternationalLocalPhone('+1991234567'), 
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
        () => validateInternationalLocalPhone('0891234567'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        ) 
      );
      expect(
        () => validateInternationalLocalPhone('+593891234567'), 
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
        () => validateInternationalLocalPhone('09912345'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength )
          )
        ) 
      );
      expect(
        () => validateInternationalLocalPhone('+59399123'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength )
          )
        ) 
      );
    });
  });

  group('validateInternationalLocalPhone landline numbers', (){
    test('return the landline number keeping the local notation', (){
      expect(validateInternationalLocalPhone('022345678'), '022345678');
      expect(validateInternationalLocalPhone('(02) 234-5678'), '022345678');
    });

    test('return the landline number keeping the international notation', (){
      expect(validateInternationalLocalPhone('+59322345678'), '+59322345678');
      expect(validateInternationalLocalPhone('0059322345678'), '+59322345678');
      expect(validateInternationalLocalPhone('+593 (0)2 234 5678'), '+59322345678');
    });

    test('return invalid format exception for an invalid area code', (){
      expect(
        () => validateInternationalLocalPhone('012345678'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        ) 
      );
    });
  });
}
