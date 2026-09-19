
# ec_validations

Validación de **cédula**, **RUC** y **números de teléfono** del Ecuador, para Dart y Flutter.

A library for validating Ecuadorian identification documents (**ID card** and **RUC**) and **phone numbers**.

#### Null-Safety · Dart 3 · sin dependencias externas / zero external dependencies

#### iOS, Android, Linux, Mac, Web, Windows

![ec_validations demo ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/validator.png 'ec_validations')

## Documentación / Documentation

[Cómo validar cédula y RUC en Ecuador](https://medium.com/@bryansuarez/c%C3%B3mo-validar-c%C3%A9dula-y-ruc-en-ecuador-b62c5666186f)

## Instalación / Installation

### 1. Agrégalo a tu `pubspec.yaml` / Add it to your `pubspec.yaml`

```yaml
dependencies:
    ec_validations: '^0.1.0'
```

### 2. Instálalo / Install it

```bash
$ flutter pub get
```

### 3. Impórtalo / Import it

```Dart
import 'package:ec_validations/ec_validations.dart';
```

## Uso / Usage

**ES** — Cada validador devuelve un resultado con `isValid`, `errorMessage` y `typeCodeError`. Ninguno lanza excepciones. Los ejemplos completos están en la carpeta `example`.

**EN** — Every validator returns a result with `isValid`, `errorMessage` and `typeCodeError`. None of them throws. Complete examples live in the `example` folder.

```dart
void main() {
  /// Cédula / ID card
  final result = DniValidator
   .isValid('0105566046');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */

  /// RUC de persona natural / natural person RUC
  final resultRucPerson = RucValidator
   .validateRucByType('0105566046001', TypeIdentification.rucPersonNatural);
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */

  /// RUC de cualquier tipo / any RUC type
  final resultRuc = RucValidator.validateRuc('0105566046001');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */

  /// Solo longitud y código de provincia / length and province code only
  final resultPossiblyValidRuc = RucValidator.isPossiblyValidRuc('0391034039001');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
}
```

### Teléfonos / Phone numbers

**ES** — `PhoneValidator` devuelve un `PhoneResult`, que añade el campo `normalizedNumber` con el número ya limpio cuando la validación es correcta.

**EN** — `PhoneValidator` returns a `PhoneResult`, which adds a `normalizedNumber` field holding the cleaned number when the validation succeeds.

> **Formatos soportados** — celulares de 10 dígitos que empiezan con `09`, y teléfonos fijos de 9 dígitos que empiezan con `02` a `07` (el código de área). Ambos funcionan en notación local e internacional (`+593…`).
>
> **Supported formats** — mobile numbers, 10 digits starting with `09`, and landline numbers, 9 digits starting with `02` to `07` (the area code). Both work in local and international (`+593…`) notation.

```dart
void main() {
  /// Acepta ambas notaciones / accepts both notations: 0991234567, +593991234567
  final result = PhoneValidator.isValid('099 123 4567');
  /**
   * isValid: true or false
   * normalizedNumber: '0991234567' or null
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */

  /// Solo notación local / only the local notation
  final resultLocal = PhoneValidator.isValidLocal('0991234567');
  /**
   * normalizedNumber: '0991234567' or null
  */

  /// Solo notación internacional / only the international notation
  final resultInternational = PhoneValidator.isValidInternational('+593 99 123 4567');
  /**
   * normalizedNumber: '+593991234567' or null
  */
}
```

**ES** — Los separadores (espacios, puntos, guiones y paréntesis) se eliminan antes de validar, e `isValid` conserva la notación de la entrada.

**EN** — Separators such as spaces, dots, dashes and parentheses are removed before validating, and `isValid` keeps the notation of the input:

| Entrada / Input | `normalizedNumber` |
| --- | --- |
| `0991234567` | `0991234567` |
| `099 123 4567` | `0991234567` |
| `(099) 123-4567` | `0991234567` |
| `+593991234567` | `+593991234567` |
| `00593991234567` | `+593991234567` |
| `593991234567` | `+593991234567` |
| `+593 (0)99 123 4567` | `+593991234567` |
| `022345678` | `022345678` |
| `(02) 234-5678` | `022345678` |
| `+59322345678` | `+59322345678` |
| `+593 (0)2 234 5678` | `+59322345678` |

**ES** — Cuando el número es inválido, `typeCodeError` es uno de `PhoneErrorCode`.

**EN** — When the number is invalid, `typeCodeError` is one of `PhoneErrorCode`:

| Código / Code | Significado / Meaning |
| --- | --- |
| `invalidEmpty` | El número está vacío<br>The number is empty |
| `invalidLength` | No tiene la longitud esperada: 10 dígitos (celular) o 9 (fijo) en local, 9 u 8 después de `+593`<br>Does not have the expected length: 10 digits (mobile) or 9 (landline) in local notation, 9 or 8 after `+593` |
| `invalidFormat` | No empieza con `09` (celular) ni con `02` a `07` (fijo) — `9` o `2` a `7` después de `+593` — o tiene caracteres que no son dígitos<br>Does not start with `09` (mobile) or `02` to `07` (landline) — `9` or `2` to `7` after `+593` — or contains non-digit characters |
| `invalidCountryCode` | No empieza con el código de Ecuador `+593`<br>Does not start with the Ecuador code `+593` |
| `invalidPhone` | Error inesperado<br>Unexpected error |

## Idiomas / Localization

**ES** — Los mensajes de validación vienen en inglés (por defecto) y español. Selecciona el idioma una vez, normalmente al arrancar la app, y todos los validadores lo siguen.

**EN** — Validation messages ship in English (default) and Spanish. Select a locale once, usually at startup, and every validator follows it:

```dart
import 'package:ec_validations/ec_validations.dart';

void main() {
  EcValidationsL10n.use('es');

  final result = DniValidator.isValid('');
  // result.errorMessage: 'La identificación no puede estar vacía'
}
```

**ES** — `use` devuelve `false` y mantiene el idioma actual cuando el código es desconocido, así que puedes pasarle directamente el locale de la plataforma.

**EN** — `use` returns `false` and keeps the current locale when the code is unknown, so it can be fed straight from the platform locale:

```dart
EcValidationsL10n.use(Localizations.localeOf(context).toLanguageTag());
```

**ES** — El código no distingue mayúsculas, `_` y `-` son intercambiables, y una región cae a su idioma: `es`, `ES`, `es-EC`, `es_EC` y `es-419` resuelven todos al catálogo en español.

**EN** — The code is matched case-insensitively, `_` and `-` are interchangeable, and a region falls back to its language: `es`, `ES`, `es-EC`, `es_EC` and `es-419` all resolve to the Spanish catalog.

**ES** — Los mensajes se resuelven al leer `errorMessage`, no al validar, así que un resultado creado antes de cambiar el idioma ya reporta el nuevo. Para leer un idioma sin cambiar el seleccionado, usa `messageIn`.

**EN** — Messages are resolved when `errorMessage` is read, not when the value is validated, so a result built before the locale changed still reports the new language. To read one locale without changing the selected one, use `messageIn`:

```dart
final result = PhoneValidator.isValid('0891234567');

result.messageIn(EcMessagesEs()); // Spanish, whatever locale is selected
```

### Mensajes propios / Custom messages

**ES** — Implementa `EcValidationsMessages` para reescribir un idioma incluido o añadir uno que no viene. `EcMessageKey` lista todos los mensajes que el paquete puede emitir, y el mapa `args` lleva los valores que el mensaje interpola, como la cantidad de dígitos esperada.

**EN** — Implement `EcValidationsMessages` to reword a shipped locale or to add one the package does not ship. `EcMessageKey` lists every message the package can emit, and the `args` map carries the values a message interpolates, such as the expected number of digits:

```dart
class MyMessagesEn implements EcValidationsMessages {
  @override
  String get localeCode => 'en';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) {
    switch (key) {
      case EcMessageKey.identificationEmpty:
        return 'Please enter your ID number';
      case EcMessageKey.identificationLengthOrFormat:
        return 'It must have ${args['digits']} digits';
      default:
        return EcMessagesEn().message(key, args);
    }
  }
}

void main() {
  EcValidationsL10n.register(MyMessagesEn());
  EcValidationsL10n.use('en');
}
```

**ES** — Registrar un código de idioma que ya existe lo reemplaza. El código se normaliza igual que en `use`, así que un catálogo declarado como `es_EC` es alcanzable como `es-EC` o `es-ec`, y tiene prioridad sobre el catálogo `es` para esos códigos.

**EN** — Registering a locale code that is already known replaces it. The code is normalized the same way `use` normalizes its argument, so a catalog declaring `es_EC` is reachable as `es-EC` or `es-ec`, and takes precedence over the plain `es` catalog for those codes.

#### Demo form valid DNI
![ec_validations form_dni ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_dni.png 'ec_validations')

#### Demo form valid RUC

![ec_validations form_ruc ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_ruc.png 'ec_validations')

#### Demo form valid Phone

![ec_validations form_phone ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_phone.png 'ec_validations')

## Roadmap

**ES** — Ideas en estudio para próximas versiones. Si usas el paquete y algo te falta, cuéntalo en el [issue tracker](https://github.com/JaviKo500/ec_validations/issues); se agradece saber para qué se está usando.

**EN** — Ideas being considered for future versions. If you use the package and something is missing, say so in the [issue tracker](https://github.com/JaviKo500/ec_validations/issues); hearing what it is used for is genuinely helpful.

- **Validación de placas** (`PlateValidator`): formato, letra de provincia y tipo de servicio, con la misma forma de resultado que los demás validadores.
  <br>**License plate validation**: format, province letter and service type, with the same result shape the other validators return.
- **La provincia como valor propio**: cédula y RUC la identifican por código numérico y una placa por letra. Exponer la provincia permitiría saber a cuál pertenece un documento, no solo si es válido.
  <br>**Province as a first-class value**: DNI and RUC identify a province by its numeric code and a plate does it by letter. Exposing the province would answer which one a document belongs to, not only whether it is valid.

## Tests / Running Tests

```bash
  flutter test
```

## License

[LICENSE](LICENSE)

## Authors

- [@JaviKo500](https://www.github.com/JaviKo500)
