
import 'dart:io';

class PathValidator{
  Future<bool> validate(String path) async{
    return await File(path).exists();
  }
}