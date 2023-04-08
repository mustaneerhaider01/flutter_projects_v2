import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';

class Helpers {
  static Future<String> uploadFile(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final fileName = DateTime.now().millisecondsSinceEpoch;
    final profileImageRef = storageRef.child('Users/$fileName');
    await profileImageRef.putFile(file);
    return profileImageRef.getDownloadURL();
  }

  static Future<File?> cropImage(File file) async {
    final cropper = ImageCropper();
    final croppedImage = await cropper.cropImage(sourcePath: file.path);
    if (croppedImage == null) {
      return null;
    }
    return File(croppedImage.path);
  }
}
