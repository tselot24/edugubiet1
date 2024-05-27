import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();
  // ignore: empty_constructor_bodies
  MediaService() {}
  Future<File?> getImageFromGallery() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final XFile? _file = await _picker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      return File(_file.path);
    }
    return null;
  }
}
