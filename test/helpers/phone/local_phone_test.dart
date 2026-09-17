import 'package:ec_validations/entities/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/helpers/index.dart';
import 'package:ec_validations/exceptions/index.dart';

void main() {
  group('validateLocalPhone Valid number', (){
    test('return equal valid number', (){
      expect( validateLocalPhone('0991234567'), '0991234567' );
      expect( validateLocalPhone(' 0991234567 '), '0991234567' );
      expect( validateLocalPhone(' 099 123 4567 '), '0991234567' );
    });
  });

  group('validateLocalPhone Invalid number', (){
    test('return empty string exception', (){
      expect( 
        () => validateLocalPhone(''), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate(( PhoneException e) => e.code == PhoneErrorCode.invalidEmpty )
          )
        )
      );
    });

    test('return invalid length exception', () {
      expect(
        () => validateLocalPhone('09912345'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength )
          )
        ) 
      );
      expect(
        () => validateLocalPhone('09912345678'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength )
          )
        ) 
      );
      expect(
        () => validateLocalPhone('abc'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength && e.code != PhoneErrorCode.invalidFormat)
          )
        ) 
      );
      expect(
        () => validateLocalPhone('00991234567'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength)
          )
        ) 
      );
    });

    test('return invalid format exception', (){
      expect(
        () => validateLocalPhone('0891234567'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        )
      );
      expect(
        () => validateLocalPhone('09abcdefgh'), 
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        )
      );
    });
  });

  group('validateLocalPhone Landline number', (){
    test('return equal valid landline number', (){
      expect( validateLocalPhone('022345678'), '022345678' );
      expect( validateLocalPhone('042345678'), '042345678' );
      expect( validateLocalPhone('072345678'), '072345678' );
      expect( validateLocalPhone(' (02) 234-5678 '), '022345678' );
    });

    test('return invalid length exception', (){
      expect(
        () => validateLocalPhone('02234567'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidLength )
          )
        )
      );
    });

    test('return invalid format exception', (){
      expect(
        () => validateLocalPhone('012345678'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        )
      );
      expect(
        () => validateLocalPhone('082345678'),
        throwsA(
          allOf(
            isA<PhoneException>(),
            predicate( ( PhoneException e ) => e.code == PhoneErrorCode.invalidFormat )
          )
        )
      );
      expect(
        () => validateLocalPhone('0223456789'),
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
