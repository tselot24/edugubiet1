// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  MediaService();

  Future<File?> getImageFromGallery() async {
    final XFile? _file = await _picker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      return File(_file.path);
    }
    return null;
  }

  Future<FilePickerResult?> pickFile() async {
    return await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );
  }
}
