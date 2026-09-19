

import 'package:ec_validations/entities/index.dart';

class EcValidationsL10n {
  
  static EcValidationsMessages _current = EcMessagesEn();

  static final Map<String, EcValidationsMessages> _registry = {
    'en': EcMessagesEn(),
    'es': EcMessagesEs(),
  };

  static EcValidationsMessages get messages => _current;

  static String _normalize( String code ) => 
    code.trim().toLowerCase().replaceAll('_', '-');

  static void register( EcValidationsMessages messages) =>
    _registry[messages.localeCode] = messages;

  static bool use(String localeCode) {
    final normalized = _normalize(localeCode);
    final found =  _registry[normalized] ?? _registry[normalized.split('-').first];
    if ( found == null ) return false;
    _current = found;
    return true;
  }
  
}