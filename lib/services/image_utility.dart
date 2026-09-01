import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUtility {
  static const double uploadMaxWidth = 1280;
  static const double uploadMaxHeight = 1280;
  static const int uploadQuality = 65;
  static const int maxUploadBytes = 8 * 1024 * 1024;

  static Future<File?> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static Future<int> totalSize(List<File> files) async {
    var bytes = 0;
    for (final file in files) {
      bytes += await file.length();
    }
    return bytes;
  }
}
