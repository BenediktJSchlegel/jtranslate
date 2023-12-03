import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jtranslate/jtranslate.dart';

class JsonCache{
  final LanguageSet _set;

  Map<String, dynamic>? _cache;

  JsonCache(this._set);

  Future<void> init() async{
    await load(_set.path);
  }

  get key => _set.key;


  Future<void> load(String path) async{
    _cache = jsonDecode(await rootBundle.loadString(path));
  }

  String? get(String translationKey){
    if(_cache == null) return null;

    return _cache![translationKey];
  }
}