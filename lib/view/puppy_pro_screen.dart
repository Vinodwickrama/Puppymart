import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:puppymart/controller/image_download_controller.dart';
import 'package:puppymart/controller/post_controller.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/textStyle.dart';
import 'package:puppymart/view/confirm_add_screen.dart';

class PuppyProScreen extends StatefulWidget {
  final Puppy puppy;
  final Image propic;
  PuppyProScreen(this.puppy, this.propic);

  @override
  _PuppyProScreenState createState() => _PuppyProScreenState();
}

class _PuppyProScreenState extends State<PuppyProScreen> {
  bool isWishListed = false;
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: colorColumnBgGrey,
            centerTitle: true,
            expandedHeight: heightScreen / 3,
            flexibleSpace: FlexibleSpaceBar(
              title: CircleAvatar(
                radius: (heightScreen / 12) + 2,
                backgroundColor: Colors.white,
                child: Hero(
                  tag: 'propic' + widget.puppy.post_id.toString(),
                  child: CircleAvatar(
                    backgroundImage: widget.propic.image,
                    radius: heightScreen / 12,
                  ),
                ),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Container(
                width: widthScreen,
                height: heightScreen / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.propic.image,
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
                        Hero(
                          tag: 'title' + widget.puppy.post_id.toString(),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.puppy.title,
                              style: textStyleTitle,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: getPuppyPhotosListForPuppyUrlsList(
                                widget.puppy.img_fire_urls),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Mobile  ',
                                        style: textStyleDistance,
                                      ),
                                      Text(
                                        widget.puppy.mobile_no.toString() ??
                                            'N/A',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyleDesc,
                                      ),
                                    ],
                                  ),

                                  // below code added for price
                                  // Padding(
                                  //   padding:
                                  //       EdgeInsets.symmetric(horizontal: 10),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.center,
                                  //     children: <Widget>[
                                  //       Text(
                                  //         'Price ',
                                  //         style: textStyleDistance,
                                  //       ),
                                  //       Text(
                                  //         (puppy.price == null)
                                  //             ? 'N/A'
                                  //             : ('Rs.' +
                                  //                 puppy.price
                                  //                     .floor()
                                  //                     .toString() +
                                  //                 '/='),
                                  //         maxLines: 1,
                                  //         overflow: TextOverflow.ellipsis,
                                  //         style: textStyleDesc,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: heightScreen / 12,
                              ),
                              FlatButton(
                                onPressed: () async {
                                  print('user clicked! ============');
                                  setState(() {
                                    isWishListed = !isWishListed;
                                  });
                                  if (isWishListed) {
                                    await PostController()
                                        .updateWishList(widget.puppy.post_id);
                                  } else {
                                    await PostController()
                                        .removeWishList(widget.puppy.post_id);
                                  }
                                },
                                color: colorBgTeal,
                                padding: EdgeInsets.all(15),
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (isWishListed)
                                        ? Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                    SizedBox(
                                      width: widthScreen / 12,
                                    ),
                                    Text(
                                      'Add to WishList',
                                      style: textStyleTitle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
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

  List<FutureBuilder> getPuppyPhotosListForPuppyUrlsList(
      List<String> puppyUrlsList) {
    List<FutureBuilder> puppyPhotosList = [];

    for (String url in puppyUrlsList) {
      FutureBuilder puppyPhotoFuture = FutureBuilder<String>(
        future: ImageDownloadController()
            .getImageDownloadUrl(widget.puppy.post_id, url),
        builder: (BuildContext context, AsyncSnapshot<String> picUrlSnapshot) {
          if (picUrlSnapshot.hasError) {
            return Text(
                "Something went wrong " + picUrlSnapshot.error.toString());
          }

          if (picUrlSnapshot.connectionState == ConnectionState.done) {
            return PuppyPhoto(
              heightScreen: MediaQuery.of(context).size.height,
              puppyImage: Image.network(
                picUrlSnapshot.data.toString(),
                fit: BoxFit.cover,
              ),
            );
          }
          return Text("loading");
        },
      );
      puppyPhotosList.add(puppyPhotoFuture);
    }
    return puppyPhotosList;
  }
}

class PuppyPhoto extends StatelessWidget {
  const PuppyPhoto({
    Key key,
    @required this.heightScreen,
    @required this.puppyImage,
  }) : super(key: key);

  final double heightScreen;
  final Image puppyImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: heightScreen / 8,
      width: heightScreen / 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: puppyImage.image,
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
