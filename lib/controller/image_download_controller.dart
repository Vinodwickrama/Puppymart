import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImageDownloadController {
  ////////////////////////////////////////////
  // Start : Impl with singleton design pattern
  static final ImageDownloadController _imageDownloadController =
      ImageDownloadController._internal();

  factory ImageDownloadController() {
    return _imageDownloadController;
  }
  ImageDownloadController._internal();

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
  Future<String> getImageDownloadUrl(
      String postId, String propicFileName) async {
    String filepath = propicFileName;
    print('Testing getImageDownloadUrl ======>>> ' + filepath); // testing
    String imageUrl;
    await storage.ref().child(filepath).getDownloadURL().then(
          (urlSnap) => imageUrl = urlSnap,
        );
    print('Testing getImageDownloadUrl ======>>> ' + imageUrl); // testing
    return imageUrl;
  }
  // End : upoloading file
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
