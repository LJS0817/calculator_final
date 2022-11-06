import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileMng {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //dir : soap, beauty, oil
  //s : date
  static Future<File> writeFile(String dir, String s) async {
    final String path = await _localPath;
    final file = await File("$path/$dir/$s.txt").create(recursive: true);
    // Write the file
    return file.writeAsString(s);
  }

  //dir : soap, beauty, oil
  //s : date
  static Future<String> readFile(String dir, String s) async {
    try {
      final String path = await _localPath;
      final file = await File("$path/$dir/$s.txt").create(recursive: true);

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return e.toString();
    }
  }

  static Future<String> readFile2(String dir) async {
    try {
      final String path = await _localPath;
      final file = await File("$path/$dir").create(recursive: true);

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return e.toString();
    }
  }

  //s : soap, beauty, oil
  static Future<String> readDirectory(String s) async {
    try {
      final String path = await _localPath;
      final file = await Directory("$path/$s").create(recursive: true);

      // Read the file
      //contents[index].path
      final contents = file.listSync(recursive: true,  followLinks: false);

    return contents.join(',').replaceAll('File: ', '').replaceAll('\'', '');
    } catch (e) {
    // If encountering an error, return 0
    return e.toString();
    }
  }
}