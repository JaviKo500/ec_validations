import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

void main() {
  group('IdentificationException Tests', () {
    test('Should create exception with code and message', () {
      const errorCode = ErrorCode.invalidType;
      const errorMessage = 'Invalid identification type';
      
      final exception = IdentificationException(errorCode, errorMessage);

      expect(exception.code, equals(errorCode));
      expect(exception.message, equals(errorMessage));
    });

    test('Should be catchable as Exception', () {
      const errorCode = ErrorCode.invalidType;
      const errorMessage = 'Invalid identification type';

      expect( () {
        throw IdentificationException(errorCode, errorMessage);
      }, throwsException);
    },);    
  });
}