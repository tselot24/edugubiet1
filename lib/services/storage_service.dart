import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageService();

  Future<String?> uploadUserPfp(
      {required File file, required String uid}) async {
    Reference fileRef = _firebaseStorage
        .ref('users/pfps')
        .child('$uid${p.extension(file.path)}');
    UploadTask task = fileRef.putFile(file);
    return task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
  }

  Future<String?> uploadFile({required File file, required String path}) async {
    Reference fileRef = _firebaseStorage
        .ref(path)
        .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}');
    UploadTask task = fileRef.putFile(file);
    return task.then((p) {
      if (p.state == TaskState.success) {
        return fileRef.getDownloadURL();
      }
      return null;
    });
  }

  Future<String?> uploadImageToChat(
      {required File file, required String chatID}) async {
    return uploadFile(file: file, path: 'chats/$chatID/images');
  }

  Future<String?> uploadVideoToChat(
      {required File file, required String chatID}) async {
    return uploadFile(file: file, path: 'chats/$chatID/videos');
  }

  Future<String?> uploadFileToChat(
      {required File file, required String chatID}) async {
    return uploadFile(file: file, path: 'chats/$chatID/files');
  }

  Future<String?> getUserProfileImageUrl(String uid) async {
    try {
      Reference fileRef = _firebaseStorage.ref('users/pfps/$uid.jpg');
      return await fileRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
