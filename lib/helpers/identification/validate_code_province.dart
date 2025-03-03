import 'package:ec_validations/entities/index.dart';
import 'package:ec_validations/exceptions/index.dart';

void validateCodeProvince ( String codeProvince ) {
  const int minProvinceCode = 0;
  const int maxProvinceCode = 24;
  final code = int.tryParse(codeProvince);
  if (code == null ||code < minProvinceCode || code > maxProvinceCode) {
    throw IdentificationException(
      ErrorCode.invalidCodeProvince,
      'Invalid province code: the first two digits must be a number between 00 and 24.',
    );
  }
}