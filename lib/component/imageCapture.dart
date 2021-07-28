import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/model/image_data.dart';
import 'package:puppymart/service/uploader.dart';

enum AppState {
  free,
  picked,
  cropped,
}

enum PhotoSelect {
  propic,
  otherPics,
}

class ImageCapture extends StatefulWidget {
  final PhotoSelect photoMode;
  ImageCapture(this.photoMode);
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  AppState state;
  File image;
  File imageTemp;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile == null) {
        Navigator.pop(context);
        return;
      }
      image = File(pickedFile.path);
    });
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: colorBgTeal,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    setState(() {
      image = null;
      state = AppState.free;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          if (image != null) ...[
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  child: Icon(
                    Icons.crop,
                    size: 40,
                    color: colorBgTeal,
                  ),
                  onPressed: () {
                    _cropImage();
                  },
                ),
                FlatButton(
                  child: Icon(
                    Icons.clear,
                    size: 40,
                    color: colorBgTeal,
                  ),
                  onPressed: () {
                    _clearImage();
                  },
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.1,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                color: colorBgTeal,
                child: ListTile(
                  leading: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                  title: Text(
                    'OK',
                    style: textStyleTitle.copyWith(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  if (widget.photoMode == PhotoSelect.propic) {
                    // 1
                    Provider.of<ImageData>(context, listen: false)
                        .updateImage(image);
                  }
                  if (widget.photoMode == PhotoSelect.otherPics) {
                    // 2
                    Provider.of<ImageData>(context, listen: false)
                        .addImagetoList(image);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
          if (image == null) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colorBgTeal,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                  child: Text(
                    'Please select photo from',
                    style: textStyleTitle.copyWith(
                        color: colorBgTeal, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: RaisedButton(
                    color: colorBgTeal,
                    child: ListTile(
                      title: Text(
                        'Camera',
                        style: textStyleTitle.copyWith(color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: RaisedButton(
                    color: colorBgTeal,
                    child: ListTile(
                      title: Text(
                        'Gallery',
                        style: textStyleTitle.copyWith(color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.insert_photo,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                ),
              ],
            )
          ],
        ],
      ),
    );
  }
}
