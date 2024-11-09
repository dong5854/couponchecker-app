import 'dart:io';

import 'package:image_picker_web/image_picker_web.dart';

class UploadFile {
  final File file;
  final String name;
  final DateTime expireDate;

  UploadFile({
    required this.file,
    required this.name,
    required this.expireDate,
  });
}

class UploadFileWeb {
  final MediaInfo file;
  final String name;
  final DateTime expireDate;

  UploadFileWeb({
    required this.file,
    required this.name,
    required this.expireDate,
  });
}