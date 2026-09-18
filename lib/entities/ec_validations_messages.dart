/// Keys for every validation message the package can emit.
///
/// A key is finer grained than an [ErrorCode]: several keys can share the same
/// code when the same failure needs a different wording, such as the third
/// digit rules of each RUC type.
enum EcMessageKey {
  // Identification
  identificationEmpty,
  identificationInvalidType,
  identificationInvalid,
  identificationNotNumber,

  /// Takes the `digits` argument: the exact length the document must have.
  identificationLengthOrFormat,

  verificationDigitNotNumber,
  verificationDigitInvalid,
  codeEstablishmentNotNumber,
  codeEstablishmentZero,
  codeProvinceInvalid,
  thirdDigitNotNumber,
  thirdDigitOutOfRange,
  thirdDigitMustBeNine,
  thirdDigitMustBeSix,

  // RUC
  rucInvalid,

  // Phone
  phoneEmpty,
  phoneInvalid,
  phoneLocalLength,
  phoneLocalFormat,

  /// Takes the `countryCode` argument: the Ecuador country code, `+593`.
  phoneCountryCode,

  /// Takes the `countryCode` argument: the Ecuador country code, `+593`.
  phoneInternationalLength,

  /// Takes the `countryCode` argument: the Ecuador country code, `+593`.
  phoneInternationalFormat,
}

abstract class EcValidationsMessages {
  String get localeCode;
  String message(EcMessageKey key, [ Map<String, Object?> args = const {} ]);
}

class EcMessagesEn implements EcValidationsMessages {
  @override
  String get localeCode => 'en';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) {
    switch (key) {
      // Identification
      case EcMessageKey.identificationEmpty:
        return 'Identification cannot be empty';
      case EcMessageKey.identificationInvalidType:
        return 'Invalid identification type';
      case EcMessageKey.identificationInvalid:
        return 'Invalid identification';
      case EcMessageKey.identificationNotNumber:
        return 'Invalid identification: must be a number.';
      case EcMessageKey.identificationLengthOrFormat:
        final digits = args['digits'] ?? 10;
        return 'Invalid identification: must be exactly $digits digits and '
            'contain only numbers.';
      case EcMessageKey.verificationDigitNotNumber:
        return 'Invalid verification digit: must be a number.';
      case EcMessageKey.verificationDigitInvalid:
        return 'Invalid verification digit.';
      case EcMessageKey.codeEstablishmentNotNumber:
        return 'Invalid code establishment: must be a number.';
      case EcMessageKey.codeEstablishmentZero:
        return 'Invalid code establishment: must be a number greater than 0.';
      case EcMessageKey.codeProvinceInvalid:
        return 'Invalid province code: the first two digits must be a number '
            'between 00 and 24.';
      case EcMessageKey.thirdDigitNotNumber:
        return 'Invalid third digit: must be a number.';
      case EcMessageKey.thirdDigitOutOfRange:
        return 'Invalid third digit: must be a number between 0 and 9.';
      case EcMessageKey.thirdDigitMustBeNine:
        return 'Invalid third digit: must be a number equal to 9.';
      case EcMessageKey.thirdDigitMustBeSix:
        return 'Invalid third digit: must be a number equal to 6.';

      // RUC
      case EcMessageKey.rucInvalid:
        return 'Invalid ruc identification';

      // Phone
      case EcMessageKey.phoneEmpty:
        return 'Phone number cannot be empty.';
      case EcMessageKey.phoneInvalid:
        return 'Invalid phone number';
      case EcMessageKey.phoneLocalLength:
        return 'Phone number must be exactly 10 characters long for a mobile '
            'number or 9 for a landline number.';
      case EcMessageKey.phoneLocalFormat:
        return 'Phone number must start with 09 for a mobile number or with '
            '02 to 07 for a landline number.';
      case EcMessageKey.phoneCountryCode:
        final countryCode = args['countryCode'] ?? '+593';
        return 'Phone number must start with the Ecuador country code '
            '$countryCode.';
      case EcMessageKey.phoneInternationalLength:
        final countryCode = args['countryCode'] ?? '+593';
        return 'Phone number must have exactly 9 digits after $countryCode '
            'for a mobile number or 8 for a landline number.';
      case EcMessageKey.phoneInternationalFormat:
        final countryCode = args['countryCode'] ?? '+593';
        return 'Phone number must continue with 9 for a mobile number or with '
            '2 to 7 for a landline number after $countryCode.';
    }
  }
}

class EcMessagesEs implements EcValidationsMessages {
  @override
  String get localeCode => 'es';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) {
    switch (key) {
      // Identification
      case EcMessageKey.identificationEmpty:
        return 'La identificación no puede estar vacía';
      case EcMessageKey.identificationInvalidType:
        return 'Tipo de identificación inválido';
      case EcMessageKey.identificationInvalid:
        return 'Identificación inválida';
      case EcMessageKey.identificationNotNumber:
        return 'Identificación inválida: debe ser un número.';
      case EcMessageKey.identificationLengthOrFormat:
        final digits = args['digits'] ?? 10;
        return 'Identificación inválida: debe tener exactamente $digits '
            'dígitos y contener solo números.';
      case EcMessageKey.verificationDigitNotNumber:
        return 'Dígito verificador inválido: debe ser un número.';
      case EcMessageKey.verificationDigitInvalid:
        return 'Dígito verificador inválido.';
      case EcMessageKey.codeEstablishmentNotNumber:
        return 'Código de establecimiento inválido: debe ser un número.';
      case EcMessageKey.codeEstablishmentZero:
        return 'Código de establecimiento inválido: debe ser un número mayor '
            'a 0.';
      case EcMessageKey.codeProvinceInvalid:
        return 'Código de provincia inválido: los dos primeros dígitos deben '
            'ser un número entre 00 y 24.';
      case EcMessageKey.thirdDigitNotNumber:
        return 'Tercer dígito inválido: debe ser un número.';
      case EcMessageKey.thirdDigitOutOfRange:
        return 'Tercer dígito inválido: debe ser un número entre 0 y 9.';
      case EcMessageKey.thirdDigitMustBeNine:
        return 'Tercer dígito inválido: debe ser un número igual a 9.';
      case EcMessageKey.thirdDigitMustBeSix:
        return 'Tercer dígito inválido: debe ser un número igual a 6.';

      // RUC
      case EcMessageKey.rucInvalid:
        return 'RUC inválido';

      // Phone
      case EcMessageKey.phoneEmpty:
        return 'El número de teléfono no puede estar vacío.';
      case EcMessageKey.phoneInvalid:
        return 'Número de teléfono inválido';
      case EcMessageKey.phoneLocalLength:
        return 'El número de teléfono debe tener exactamente 10 caracteres '
            'para un celular o 9 para un teléfono fijo.';
      case EcMessageKey.phoneLocalFormat:
        return 'El número de teléfono debe empezar con 09 para un celular o '
            'con 02 a 07 para un teléfono fijo.';
      case EcMessageKey.phoneCountryCode:
        final countryCode = args['countryCode'] ?? '+593';
        return 'El número de teléfono debe empezar con el código de país de '
            'Ecuador $countryCode.';
      case EcMessageKey.phoneInternationalLength:
        final countryCode = args['countryCode'] ?? '+593';
        return 'El número de teléfono debe tener exactamente 9 dígitos '
            'después de $countryCode para un celular u 8 para un teléfono '
            'fijo.';
      case EcMessageKey.phoneInternationalFormat:
        final countryCode = args['countryCode'] ?? '+593';
        return 'El número de teléfono debe continuar con 9 para un celular o '
            'con 2 a 7 para un teléfono fijo después de $countryCode.';
    }
  }
}
