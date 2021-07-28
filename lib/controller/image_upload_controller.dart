import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/service/file_name_service.dart';

class ImageUploadController {
  ////////////////////////////////////////////
  // Start : Impl with singleton design pattern
  static final ImageUploadController _imageUploadController =
      ImageUploadController._internal();

  factory ImageUploadController() {
    return _imageUploadController;
  }
  ImageUploadController._internal();

  // End : Impl with singleton design pattern
  ////////////////////////////////////////////

  ////////////////////////////////////////////
  // Start: Firebase Object ini
  FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://puppymart-23f43.appspot.com');
  // End : Firebase Object ini
  ////////////////////////////////////////////

  ////////////////////////////////////////////
  // Start: upoloading file
  Future<String> uploadFile(String postId, File imagePropic) async {
    String filePath = 'PostImages/$postId/images/';
    String filename;
    String fullFilePath;
    try {
      filename = FileNameService.getFileNameFromDateTime(
          DateTime.now(), authService.auth.currentUser.uid);
      fullFilePath = filePath + filename;
      storage.ref().child(fullFilePath).putFile(imagePropic);
      print('==== Image filepath ====>>>> ' + filePath + filename);
    } on Exception catch (e) {
      filename = null;
      print(e.toString());
      // e.g, e.code == 'canceled'
    }
    return fullFilePath;
  }
  // End : upoloading file
  ////////////////////////////////////////////

  ////////////////////////////////////////////
  // Start: upoloading files
  Future<List<String>> uploadManyFiles(
      String filePath, List<File> imageList) async {
    List<String> filenameList = [];
    for (File image in imageList) {
      try {
        String filename = DateTime.now().toString();
        await storage.ref().child(filePath + filename).putFile(image);
        filenameList.add(filePath + filename);

        print('===============>>>>  Hello >>>   ' + filePath + filename);
      } on Exception catch (e) {
        print(e.toString());
        // e.g, e.code == 'canceled'
      }
    }
    return filenameList;
  }
  // End : upoloading files
  ////////////////////////////////////////////

////////////////////////////////////////////
// Start: Firebase Object ini
// End : Firebase Object ini
////////////////////////////////////////////
////////////////////////////////////////////
// Start: Firebase Object ini
// End : Firebase Object ini
////////////////////////////////////////////
}
