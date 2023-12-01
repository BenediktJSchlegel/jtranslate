library jtranslate_generator;

import 'package:build/build.dart';

import 'src/json_to_code_builder.dart';

export 'src/jtranslator.dart';
export 'src/configuration/jtranslator_configuration.dart';
export 'src/configuration/language_set.dart';

Builder jsonToCodeBuilder(BuilderOptions options) =>
    JsonToCodeBuilder(options);

