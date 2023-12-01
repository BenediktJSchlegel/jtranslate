
import 'package:jtranslate/jtranslate_generator.dart';
import 'package:jtranslate/src/validation/key_validation.dart';
import 'package:jtranslate/src/validation/path_validation.dart';

import 'classes/json_cache.dart';

class JTranslator{

  final JTranslatorConfiguration _configuration;

  JsonCache? _activeCache;
  JsonCache? _fallbackCache;

  List<JsonCache>? _allCaches;

  JTranslator(this._configuration){
    _validate();

    if(this._configuration.preCacheAllLanguages){
      _preCacheAll();

      _fallbackCache = _allCaches!.firstWhere((element) => element.key == _configuration.fallbackKey);
      _activeCache = _allCaches!.firstWhere((element) => element.key == _configuration.initialKey);
    }else{
      _fallbackCache = generateCache(_configuration.fallbackKey);

      if(_configuration.fallbackKey == _configuration.initialKey){
        _activeCache = _fallbackCache;
      }else{
        _activeCache = generateCache(_configuration.initialKey);
      }
    }
  }

  void _validate(){
    KeyValidation.keyExistsInSets(_configuration.sets, _configuration.initialKey);
    KeyValidation.keyExistsInSets(_configuration.sets, _configuration.fallbackKey);
    KeyValidation.checkKeyDuplicates(_configuration.sets);

    _configuration.sets.map((e) => e.path).forEach((path) {
      PathValidation.validate(path);
    });
  }

  void _preCacheAll(){

  }

  JsonCache generateCache(String key){
    return JsonCache(_configuration.sets.firstWhere((set) => set.key == key));
  }

  void set(String key){
    if(_configuration.preCacheAllLanguages && _allCaches != null && _allCaches!.isNotEmpty){
      _activeCache = _allCaches!.firstWhere((cache) => cache.key == key);
      return;
    }

    _activeCache = generateCache(key);
  }

  String get(String translationKey){
    String? value = _activeCache!.get(translationKey);

    if(value != null){
      return value;
    }

    String? fallback = _fallbackCache!.get(translationKey);

    if(fallback != null){
      return fallback;
    }

    return _configuration.outOfSetToken;
  }

}