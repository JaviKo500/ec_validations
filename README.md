
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
    ec_validations: '^0.0.15'
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

#### Demo form valid DNI
![ec_validator form_dni ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_dni.png 'Ec_validator')

#### Demo form valid RUC

![ec_validator form_ruc ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_ruc.png 'Ec_validator')

#### Demo form valid Phone

![ec_validator form_phone ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_phone.png 'Ec_validator')

## Running Tests

To run tests, run the following command

```bash
  flutter test
```


## License

[LICENSE](LICENSE)


## Authors

- [@JaviKo500](https://www.github.com/JaviKo500)

