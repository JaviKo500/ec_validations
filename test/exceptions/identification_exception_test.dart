import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

void main() {
  group('IdentificationException Tests', () {
    test('Should create exception with code and message', () {
      const errorCode = ErrorCode.invalidType;
      
      final exception = IdentificationException(errorCode, EcMessageKey.identificationInvalidType,);

      expect(exception.code, equals(errorCode));
      expect(exception.key, equals(EcMessageKey.identificationInvalidType));
      expect(exception.message, equals('Invalid identification type'));
    });

    test('Should be catchable as Exception', () {
      const errorCode = ErrorCode.invalidType;
      expect( () {
        throw IdentificationException(errorCode, EcMessageKey.identificationInvalidType,);
      }, throwsException);
    },);    
  });
}