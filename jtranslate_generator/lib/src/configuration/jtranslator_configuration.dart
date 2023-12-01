
import 'language_set.dart';

class JTranslatorConfiguration{
  final List<LanguageSet> _sets;

  JTranslatorConfiguration(this._sets);

  List<LanguageSet> get sets => _sets;
}