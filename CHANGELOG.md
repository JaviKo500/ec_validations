## 0.1.1
* Documentation only: no API or behavior changes.
* The README is now bilingual, Spanish and English, matching the audience of the package.
* Fix the README title, which named ec_validator, the demo app, instead of ec_validations.
* Add a Roadmap section with the validations under consideration.
## 0.1.0
* Localize every validation message: EcValidationsL10n.use selects a locale, shipped in English (default) and Spanish.
* Results and exceptions carry an EcMessageKey instead of a fixed string, so errorMessage follows the locale selected when it is read.
* Add IdentificationResult.messageIn and PhoneResult.messageIn to read one locale without selecting it.
* Add EcValidationsL10n.register to reword a shipped locale or add a new one.
* Breaking: IdentificationException and PhoneException take an EcMessageKey instead of a message string.
## 0.0.15
* Add phone number validation: PhoneValidator.isValid, isValidLocal and isValidInternational.
* Phone validation supports mobile (09) and landline (02-07) numbers.
## 0.0.14
* Update validation third digit dni and rucPersonNatural.
## 0.0.13
* Dart format code.
## 0.0.12
* Update changelog format.
## 0.0.11
* Update changelog.
## 0.0.10
* Fix validation for foreign DNI and add method to check if RUC is possibly valid.
## 0.0.9
* Dart format code.
## 0.0.8 
* Check if verification digit is 0.
## 0.0.7
* Update readme.
## 0.0.6 
* Update readme.
## 0.0.5 
* Update readme.
## 0.0.4
* Update example main.
## 0.0.3
*Update examples and add readme.
## 0.0.2
* Update documentation readme images.
## 0.0.1
* Validate RUC and DNI through a static method RucValidator.validateRuc('') - DniValidator.isValid('').