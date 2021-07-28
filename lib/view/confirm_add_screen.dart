import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:puppymart/controller/image_upload_controller.dart';
import 'package:puppymart/controller/post_controller.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/textStyle.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/view/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:puppymart/view/puppy_ad_screen.dart';

class ConfirmAddScreen extends StatefulWidget {
  final Puppy puppy;

  ConfirmAddScreen(this.puppy);

  @override
  _ConfirmAddScreenState createState() => _ConfirmAddScreenState();
}

class _ConfirmAddScreenState extends State<ConfirmAddScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _isLoading
          ? SpinKitDoubleBounce(
              size: 70,
              color: colorBgTeal,
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: colorColumnBgGrey,
                  centerTitle: true,
                  expandedHeight: heightScreen / 3,
                  flexibleSpace: FlexibleSpaceBar(
                    title: CircleAvatar(
                      radius: (heightScreen / 12) + 2,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: FileImage(widget.puppy.imgPropic_url),
                        radius: heightScreen / 12,
                      ),
                    ),
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      width: widthScreen,
                      height: heightScreen / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(widget.puppy.imgPropic_url),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        color: colorColumnBgGrey,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  widget.puppy.title,
                                  style: textStyleTitle,
                                  maxLines: 3,
                                ),
                              ),
                              SingleChildScrollView(
                                padding: EdgeInsets.all(10),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: getPuppyPhotos(
                                      heightScreen, widget.puppy.img_urls),
                                ),
                              ),
                              SingleChildScrollView(
                                physics: ScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                dragStartBehavior: DragStartBehavior.start,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    DetailCard(
                                      heightScreen: heightScreen,
                                      titleText: 'Age',
                                      detailText: '2 Years',
                                    ),
                                    DetailCard(
                                      heightScreen: heightScreen,
                                      titleText: 'Breed',
                                      detailText: widget.puppy.breed,
                                    ),
                                    DetailCard(
                                      heightScreen: heightScreen,
                                      titleText: 'Weight',
                                      detailText: '2kg',
                                    ),
                                    DetailCard(
                                      heightScreen: heightScreen,
                                      titleText: 'Gender',
                                      detailText: widget.puppy.gender ?? 'N/A',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Province  ',
                                              style: textStyleDistance,
                                            ),
                                            Text(
                                              widget.puppy.city,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textStyleDesc,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Town  ',
                                              style: textStyleDistance,
                                            ),
                                            Text(
                                              widget.puppy.town,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textStyleDesc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'District  ',
                                              style: textStyleDistance,
                                            ),
                                            Text(
                                              widget.puppy.town,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textStyleDesc,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  widget.puppy.description,
                                  style: textStyleDesc,
                                  maxLines: 25,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Mobile  ',
                                              style: textStyleDistance,
                                            ),
                                            Text(
                                              widget.puppy.mobile_no
                                                      .toString() ??
                                                  'N/A',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textStyleDesc,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Price ',
                                                style: textStyleDistance,
                                              ),
                                              Text(
                                                (widget.puppy.price == null)
                                                    ? 'N/A'
                                                    : ('Rs.' +
                                                        widget.puppy.price
                                                            .floor()
                                                            .toString() +
                                                        '/='),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyleDesc,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: heightScreen / 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton(
                                          child: Text(
                                            'Back',
                                            style: textStyleTitle.copyWith(
                                              color: Colors.white54,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 50),
                                          color: colorBgTeal,
                                          onPressed: () {},
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            'Confirm',
                                            style: textStyleTitle.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 50),
                                          color: colorBgTeal,
                                          // onPressed: () async {

                                          // },
                                          onPressed: () async {
                                            // sets the puppy objects file reference names

                                            User currentUser =
                                                authService.auth.currentUser;
                                            if (currentUser != null) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              // Add puppy post
                                              await PostController()
                                                  .addNewPuppyPost(
                                                      context, widget.puppy);
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            } else {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return LoginScreen(context);
                                              }));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
    );
  }

  List<PuppyPhoto> getPuppyPhotos(double heightScreen, List<File> photoList) {
    List<PuppyPhoto> puppyPhotoList = [];
    for (File tempPhotoFile in photoList) {
      PuppyPhoto puppyPic = PuppyPhoto(
        heightScreen: heightScreen,
        puppyImageUrl: tempPhotoFile,
      );
      puppyPhotoList.add(puppyPic);
    }
    return puppyPhotoList;
  }

  Future<bool> uploadImages(File image) {}
}

class PuppyPhoto extends StatelessWidget {
  const PuppyPhoto({
    Key key,
    @required this.heightScreen,
    @required this.puppyImageUrl,
  }) : super(key: key);

  final double heightScreen;
  final File puppyImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: heightScreen / 8,
      width: heightScreen / 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: FileImage(puppyImageUrl),
          fit: BoxFit.fill,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key key,
    @required this.heightScreen,
    @required this.titleText,
    @required this.detailText,
  }) : super(key: key);

  final double heightScreen;
  final String titleText;
  final String detailText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: heightScreen / 10,
      width: heightScreen / 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            titleText,
            style: textStyleTitle.copyWith(color: Colors.white),
          ),
          Text(
            detailText,
            style: textStyleDistance,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0x6F416C6E),
      ),
    );
  }
}
