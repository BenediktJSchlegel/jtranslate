
import 'language_set.dart';

class JTranslatorConfiguration{
  //final AssetBundle _assetBundle;
  final List<LanguageSet> _sets;
  final String _initialKey;
  final String _fallbackKey;
  final bool _preCacheAllLanguages;
  final String _outOfSetToken;

  /// [sets]: Sets of key and their associated path \n
  ///
  /// [initialKey]: The key to first initialize the set for.
  ///
  /// [preCacheAllLanguages]:  If all language files should be pre-cached. This will increase memory usage but
  /// requires less processing when regularly switching between languages.
  ///
  /// [outOfSetToken]: The token that is returned when the translation-key is not present in the active and the fallback set.
  ///
  /// [fallbackKey]: The set key to fall back to when a translation-key is not present in the currently active set.
  /// If the translation-key is not present in the fallback either, the `outOfSetToken` is used.
  JTranslatorConfiguration({
    required List<LanguageSet> sets,
    required String fallbackKey,
    required bool preCacheAllLanguages,
    required String outOfSetToken,
    required String initialKey}) :
        _sets = sets,
        _fallbackKey = fallbackKey,
        _outOfSetToken = outOfSetToken,
        _preCacheAllLanguages = preCacheAllLanguages,
        _initialKey = initialKey;

  List<LanguageSet> get sets => _sets;

  String get outOfSetToken => _outOfSetToken;

  bool get preCacheAllLanguages => _preCacheAllLanguages;

  String get fallbackKey => _fallbackKey;

  String get initialKey => _initialKey;
}