import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:io';

class ImageData extends ChangeNotifier {
  File _imagePro = File('images/puppyplaceholder.png');
  List<File> _photoList = [];

  File get imagePro {
    return _imagePro;
  }

  UnmodifiableListView<File> get photoList {
    return UnmodifiableListView(_photoList);
  }

  int get photoCount {
    return _photoList.length;
  }

  updateImage(File file) {
    _imagePro = file;
    notifyListeners();
    print('image Data ' + file.path);
  }

  addImagetoList(File file) {
    _photoList.add(file);
    notifyListeners();
    print('photolist Data ' + file.path);
  }

  removeImageFromList(File file) {
    _photoList.remove(file);
    notifyListeners();
    //print('photolist Data ' + file.path);

    for (File file in _photoList) {
      print('photolist ' + _photoList.length.toString() + '  ' + file.path);
    }
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');
  //
  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return file;
  // }

  // Update Auth pro user pic of side menu

  Image _authProPic = Image.asset('images/logo.png');

  Image get authProPic {
    return _authProPic;
  }

  updateAuthProImage(Image authPic) {
    _authProPic = authPic;
    notifyListeners();
  }

  updateNoAuthProImage() {
    _authProPic = Image.asset('images/logo.png');
    notifyListeners();
  }
}
