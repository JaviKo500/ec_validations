

import 'package:ec_validations/entities/index.dart';

class EcValidationsL10n {
  
  static EcValidationsMessages _current = EcMessagesEn();

  static final Map<String, EcValidationsMessages> _registry = {
    'en': EcMessagesEn(),
    'es': EcMessagesEs(),
  };

  static EcValidationsMessages get messages => _current;

  static void register( EcValidationsMessages messages) =>
    _registry[messages.localeCode] = messages;

  static bool use(String localeCode) {
    final found = _registry[localeCode];
    if ( found == null ) return false;
    _current = found;
    return true;
  }
  
}