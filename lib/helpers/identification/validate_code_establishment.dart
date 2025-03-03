import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

void validateCodeEstablishment ( String codeEstablishment ) {
  final code = int.tryParse(codeEstablishment);
  if (code == null) {
    throw IdentificationException(
      ErrorCode.invalidCodeEstablishment,
      'Invalid code establishment: must be a number.',
    );
  }

  if ( code <= 0 ) {
    throw IdentificationException(
      ErrorCode.invalidCodeEstablishment,
      'Invalid code establishment: must be a number greater than 0.',
    );
  }
}