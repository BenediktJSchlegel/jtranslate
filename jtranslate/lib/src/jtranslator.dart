
import 'package:jtranslate/jtranslate.dart';
import 'package:jtranslate/src/validation/key_validation.dart';

import 'classes/json_cache.dart';

class JTranslator{

  final JTranslatorConfiguration _configuration;

  JsonCache? _activeCache;
  JsonCache? _fallbackCache;

  List<JsonCache>? _allCaches;

  JTranslator(this._configuration){
    _validate();
  }

  Future<bool> init() async{
    if(this._configuration.preCacheAllLanguages){
      await _preCacheAll();

      _fallbackCache = _allCaches!.firstWhere((element) => element.key == _configuration.fallbackKey);
      _activeCache = _allCaches!.firstWhere((element) => element.key == _configuration.initialKey);
    }else{
      _fallbackCache = await generateCache(_configuration.fallbackKey);

      if(_configuration.fallbackKey == _configuration.initialKey){
        _activeCache = _fallbackCache;
      }else{
        _activeCache = await generateCache(_configuration.initialKey);
      }
    }

    return true;
  }

  void _validate(){
    KeyValidation.keyExistsInSets(_configuration.sets, _configuration.initialKey);
    KeyValidation.keyExistsInSets(_configuration.sets, _configuration.fallbackKey);
    KeyValidation.checkKeyDuplicates(_configuration.sets);
  }

  Future<void> _preCacheAll() async{
    _allCaches = List.empty();

    _configuration.sets.forEach((element) async {
      _allCaches!.add(await generateCache(element.key));
    });
  }

  Future<JsonCache> generateCache(String key) async{
    final JsonCache cache = JsonCache(_configuration.sets.firstWhere((set) => set.key == key));
    await cache.init();

    return cache;
  }

  Future<void> set(String key) async{
    if(_configuration.preCacheAllLanguages && _allCaches != null && _allCaches!.isNotEmpty){
      _activeCache = _allCaches!.firstWhere((cache) => cache.key == key);
      return;
    }

    _activeCache = await generateCache(key);
  }

  operator [](String translationKey) => get(translationKey);

  String get(String translationKey){
    if(_activeCache == null)
      return _configuration.outOfSetToken;

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

  void x() async{

  }

}