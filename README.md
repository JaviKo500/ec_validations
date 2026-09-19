
# ec_validator

A library for validating Ecuadorian identification documents (ID card and RUC) and phone numbers.

#### Null-Safety, Dart 3, with zero external dependencies

#### iOS, Android, Linux, Mac, Web, Windows ready

![ec_validator demo ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/validator.png 'Ec_validator')

## Documentation

[Documentation](https://medium.com/@bryansuarez/c%C3%B3mo-validar-c%C3%A9dula-y-ruc-en-ecuador-b62c5666186f)

## **Installation**

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    ec_validations: '^0.1.0'
```


#### 2. Install it

You can install packages from the command line:

```bash
$ pub get
..
```

Alternatively, your editor might support pub. Check the docs for your editor to learn more.

#### 3. Import it

Now in your Dart code, you can use:

```Dart
import 'package:ec_validations/ec_validations.dart';
```

## Usage/Examples

For complete examples, check the `example` folder inside the repository

```dart
void main() {
  final result = DniValidator
   .isValid('0105566046');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
  final resultRucPerson = RucValidator
   .validateRucByType('0105566046001', TypeIdentification.rucPersonNatural);
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
  final resultRuc = RucValidator.validateRuc('0105566046001');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
  final resultPossiblyValidRuc = RucValidator.isPossiblyValidRuc('0391034039001');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
}
```

### Phone numbers

`PhoneValidator` returns a `PhoneResult`, which adds a `normalizedNumber` field
holding the cleaned number when the validation succeeds.

> **Supported formats:** mobile numbers, 10 digits starting with `09`, and
> landline numbers, 9 digits starting with `02` to `07` (the area code). Both
> work in local and international (`+593…`) notation.

```dart
void main() {
  /// Accepts both notations: 0991234567 and +593991234567
  final result = PhoneValidator.isValid('099 123 4567');
  /**
   * isValid: true or false
   * normalizedNumber: '0991234567' or null
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */

  /// Only the local notation
  final resultLocal = PhoneValidator.isValidLocal('0991234567');
  /**
   * normalizedNumber: '0991234567' or null
  */

  /// Only the international notation
  final resultInternational = PhoneValidator.isValidInternational('+593 99 123 4567');
  /**
   * normalizedNumber: '+593991234567' or null
  */
}
```

Separators such as spaces, dots, dashes and parentheses are removed before
validating, and `isValid` keeps the notation of the input:

| Input | `normalizedNumber` |
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

When the number is invalid, `typeCodeError` is one of `PhoneErrorCode`:

| Code | Meaning |
| --- | --- |
| `invalidEmpty` | The number is empty |
| `invalidLength` | The number does not have the expected length: 10 digits (mobile) or 9 (landline) in local notation, 9 or 8 after `+593` |
| `invalidFormat` | The number does not start with `09` (mobile) or `02` to `07` (landline) — `9` or `2` to `7` after `+593` — or contains non-digit characters |
| `invalidCountryCode` | The number does not start with the Ecuador code `+593` |
| `invalidPhone` | Unexpected error |

## Localization

Validation messages ship in English (default) and Spanish. Select a locale once,
usually at startup, and every validator follows it:

```dart
import 'package:ec_validations/ec_validations.dart';

void main() {
  EcValidationsL10n.use('es');

  final result = DniValidator.isValid('');
  // result.errorMessage: 'La identificación no puede estar vacía'
}
```

`use` returns `false` and keeps the current locale when the code is unknown, so
it can be fed straight from the platform locale:

```dart
EcValidationsL10n.use(Localizations.localeOf(context).toLanguageTag());
```

The code is matched case-insensitively, `_` and `-` are interchangeable, and a
region falls back to its language: `es`, `ES`, `es-EC`, `es_EC` and `es-419` all
resolve to the Spanish catalog.

Messages are resolved when `errorMessage` is read, not when the value is
validated, so a result built before the locale changed still reports the new
language. To read one locale without changing the selected one, use
`messageIn`:

```dart
final result = PhoneValidator.isValid('0891234567');

result.messageIn(EcMessagesEs()); // Spanish, whatever locale is selected
```

### Custom messages

Implement `EcValidationsMessages` to reword a shipped locale or to add one the
package does not ship. `EcMessageKey` lists every message the package can emit,
and the `args` map carries the values a message interpolates, such as the
expected number of digits:

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

Registering a locale code that is already known replaces it. The code is
normalized the same way `use` normalizes its argument, so a catalog declaring
`es_EC` is reachable as `es-EC` or `es-ec`, and takes precedence over the plain
`es` catalog for those codes.

#### Demo form valid DNI
![ec_validator form_dni ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_dni.png 'Ec_validator')

#### Demo form valid RUC

![ec_validator form_ruc ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_ruc.png 'Ec_validator')

#### Demo form valid Phone

![ec_validator form_phone ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_phone.png 'Ec_validator')

## Roadmap

Ideas being considered for future versions. Feedback and use cases are welcome
in the [issue tracker](https://github.com/JaviKo500/ec_validations/issues).

- **License plate validation** (`PlateValidator`): format, province letter and
  service type, with the same result shape the other validators return.
- **Province as a first-class value**: DNI and RUC identify a province by its
  numeric code and a plate does it by letter. Exposing the province itself would
  let the package answer which one a document belongs to, not only whether it is
  valid.

## Running Tests

To run tests, run the following command

```bash
  flutter test
```


## License

[LICENSE](LICENSE)


## Authors

- [@JaviKo500](https://www.github.com/JaviKo500)

