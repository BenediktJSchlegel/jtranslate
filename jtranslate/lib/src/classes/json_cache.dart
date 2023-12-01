
import 'dart:convert';

import 'package:jtranslate/jtranslate_generator.dart';

class JsonCache{
  final LanguageSet _set;

  Map<String, String> _cache;

  JsonCache(this._set) : _cache = load(_set.path);

  get key => _set.key;


  static Map<String, String> load(String path){
    return jsonDecode(path);
  }

  String? get(String translationKey){
    return _cache[translationKey];
  }
}