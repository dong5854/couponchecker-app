import 'dart:io';

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