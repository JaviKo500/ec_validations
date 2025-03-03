
# ec_validator

A library for validating Ecuadorian identification documents (ID card and RUC)."

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
    ec_validations: '^0.0.2'
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
import 'package:ec_validator/entities/index.dart';
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
}
```
#### Demo form valid DNI
![ec_validator form_dni ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_dni.png 'Ec_validator')

#### Demo form valid RUC

![ec_validator form_ruc ](https://raw.githubusercontent.com/JaviKo500/ec_validations/main/screenshots/valid_ruc.png 'Ec_validator')

## Running Tests

To run tests, run the following command

```bash
  flutter test
```


## License

[LICENSE](LICENSE)


## Authors

- [@JaviKo500](https://www.github.com/JaviKo500)

