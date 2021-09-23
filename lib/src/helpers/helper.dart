import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> createFileFromByteData(Uint8List data) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  String fullPath = '$dir/test.png';
  print("local file full path $fullPath");
  File file = File(fullPath);
  await file.writeAsBytes(data);
  print(file.path);

  return file.path;
}

bool passwordValidation(String str) {
  print(RegExp(r'([a-zA-Z]+)').hasMatch(str) && RegExp(r'([0-9]+)').hasMatch(str));
  return RegExp(r'([a-zA-Z]+)').hasMatch(str) && RegExp(r'([0-9]+)').hasMatch(str);
}
