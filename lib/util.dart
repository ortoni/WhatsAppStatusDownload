import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

Future<Directory> get localFile async {
  var path = await localPath;
  return Directory('$path/WhatsApp/Media/.Statuses/');
}
