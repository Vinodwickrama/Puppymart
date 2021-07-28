import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppymart/component/imageCapture.dart';
import 'package:puppymart/controller/post_controller.dart';
import 'package:puppymart/model/image_data.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/service/uploader.dart';
import 'package:puppymart/model/image_data.dart';
import 'package:puppymart/view/confirm_add_screen.dart';
import 'dart:io';
import '../constant.dart';

class PostAddScreen4 extends StatefulWidget {
  final Puppy puppy;
  PostAddScreen4(this.puppy);

  @override
  _PostAddScreen4State createState() => _PostAddScreen4State();
}

class _PostAddScreen4State extends State<PostAddScreen4> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload Photos',
          style: textStyleMainTitle.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: colorBgTeal,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: _screenHeight,
        width: _screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'upload the profile picture',
                    style: textStyleTitle.copyWith(
                      color: colorBgTeal,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: CircleAvatar(
                                  backgroundImage: FileImage(
                                      Provider.of<ImageData>(context).imagePro),
                                  radius: (_screenWidth / 4) + 2,
                                ),
                              ),
                            ),
                            Align(
                              child: Center(
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                  size: _screenWidth / 5,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ImageCapture(PhotoSelect
                                    .propic); // 1 = propic & 2 = other photos
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Upload Additional photos',
              maxLines: 1,
              style: textStyleTitle.copyWith(
                color: colorBgTeal,
                fontSize: 15,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              child: Wrap(
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: getOtherImageItems(context, _screenWidth),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text(
                'Next',
                style: textStyleTitle.copyWith(
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              color: colorBgTeal,
              onPressed: () {
                PostController().loadPosts();
                widget.puppy.imgPropic_url =
                    Provider.of<ImageData>(context, listen: false).imagePro;
                widget.puppy.img_urls =
                    Provider.of<ImageData>(context, listen: false).photoList;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmAddScreen(widget.puppy),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  List<Widget> getOtherImageItems(BuildContext context, double screenWidth) {
    UnmodifiableListView photoList = Provider.of<ImageData>(context).photoList;
    List<Widget> otherPhotoItems = [];
    for (File otherPhoto in photoList) {
      OtherPhotoItem otherItem = OtherPhotoItem(
        screenWidth: screenWidth,
        otherPhoto: otherPhoto,
      );
      otherPhotoItems.add(otherItem);
    }
    otherPhotoItems.add(AddOtherPhotoItem(screenWidth));
    return otherPhotoItems;
  }

  /*
FutureBuilder(
                            future: image,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                File imageFile = snapshot.data;
                                return CircleAvatar(
                                  radius: _screenWidth / 4,
                                  backgroundImage: AssetImage(imageFile.path),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                return Icon(
                                  Icons.add_circle_outline,
                                  size: _screenWidth / 8,
                                );
                              }
                            },
                          ),

   */
}

class OtherPhotoItem extends StatelessWidget {
  final double screenWidth;
  final File otherPhoto;
  OtherPhotoItem({this.screenWidth, this.otherPhoto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: screenWidth / 5,
        height: screenWidth / 5,
        color: colorColumnBgGrey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Image(
                  image: FileImage(otherPhoto),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              child: Center(
                child: Icon(
                  Icons.remove_circle_outline_rounded,
                  color: Colors.white,
                  size: screenWidth / 10,
                ),
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
      onTap: () {
        Provider.of<ImageData>(context, listen: false)
            .removeImageFromList(otherPhoto);
      },
    );
  }
}

class AddOtherPhotoItem extends StatelessWidget {
  final double screenWidth;
  AddOtherPhotoItem(
    this.screenWidth,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: screenWidth / 5,
        height: screenWidth / 5,
        color: colorColumnBgGrey,
        child: Center(
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: screenWidth / 10,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ImageCapture(
                  PhotoSelect.otherPics); // 1 = propic & 2 = other photos
            },
          ),
        );
      },
    );
  }
}
