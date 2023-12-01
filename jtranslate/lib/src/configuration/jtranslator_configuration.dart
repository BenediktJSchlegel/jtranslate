
import 'language_set.dart';

class JTranslatorConfiguration{
  /// Sets of key and their associated path
  final List<LanguageSet> _sets;
  /// The key to first initialize the set for.
  final String _initialKey;
  /// The set key to fall back to when a translation-key is not present in the currently active set.
  /// If the translation-key is not present in the fallback either, the `outOfSetToken` is used.
  final String _fallbackKey;
  /// If all language files should be pre-cached. This will increase memory usage but
  /// requires less processing when regularly switching between languages.
  final bool _preCacheAllLanguages;
  /// The token that is returned when the translation-key is not present in the active and the fallback set.
  final String _outOfSetToken;

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