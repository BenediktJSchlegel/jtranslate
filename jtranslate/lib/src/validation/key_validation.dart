
import 'package:jtranslate/src/exceptions/jtranslator_misconfiguration_exception.dart';

import '../../jtranslate_generator.dart';

class KeyValidation{

  static void checkKeyDuplicates(List<LanguageSet> sets){
    List<String> keys = sets.map((e) => e.key).toList();

    keys.forEach((element) {
      if(keys.contains(element)){
        throw JTranslatorMisconfigurationException("Duplicate Set-Key: $element");
      }
    });
  }

  static void keyExistsInSets(List<LanguageSet> sets, String key){
    if(sets.map((e) => e.key == key).isEmpty){
      throw JTranslatorMisconfigurationException("Key does not exist: $key");
    }
  }
}