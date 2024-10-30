import 'package:couponchecker/model/upload_file.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUploader {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(UploadFile uploadFile) async {
    final String formattedDate = uploadFile.expireDate.toIso8601String();
    final String filePath = 'couponchecker/$formattedDate-${uploadFile.name}-${uploadFile.file.path.split('/').last}';

    try {
      final ref = storage.ref(filePath);
      final uploadTask = await ref.putFile(uploadFile.file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }
}