
import 'dart:io';

import 'package:jtranslate/src/exceptions/jtranslator_misconfiguration_exception.dart';

class PathValidation{
  static Future<void> validate(String path) async{
    if(!(await File(path).exists())){
      throw JTranslatorMisconfigurationException("File does not exist: $path}");
    }
  }
}