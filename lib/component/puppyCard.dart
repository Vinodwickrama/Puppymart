import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/controller/image_download_controller.dart';
import 'package:puppymart/textStyle.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/view/puppy_pro_screen.dart';

class PuppyCard extends StatelessWidget {
  final Puppy puppy;
  PuppyCard(this.puppy);
  Image propic;

  @override
  Widget build(BuildContext context) {
    final double heightCard = 176 + MediaQuery.of(context).size.height / 10.0;
    final double widthCard = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (propic != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PuppyProScreen(puppy, propic);
              },
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Container(
          height: heightCard,
          width: widthCard,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.centerEnd,
                width: widthCard,
                height: heightCard,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(3, 2),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(heightCard * 0.05),
                  width: (widthCard) / 2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: 'title' + puppy.post_id.toString(),
                        child: Text(
                          puppy.title ?? 'N/A',
                          style: textStyleTitle,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        puppy.breed ?? 'N/A',
                        style: textStyleDesc,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        puppy.description ?? 'N/A',
                        style: textStyleDesc,
                        maxLines: 2,
                      ),
                      // Below added to price purpose
                      // Text(
                      //   (puppy.price != null)
                      //       ? 'Price : ' + puppy.price.floor().toString() + '/='
                      //       : 'N/A',
                      //   style: textStyleDistance,
                      //   maxLines: 1,
                      // ),
                      // Text(
                      //   (puppy.isNegotiable == 1) ? '(Negotiable)' : ' ',
                      //   style: textStyleNegotiation,
                      //   maxLines: 3,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.wc,
                            color: colorBgTeal,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            puppy.gender,
                            style: textStyleDistance,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Text(
                        'Published on ${puppy.post_dateTime.toString()}',
                        style: textStylePubDate,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 2),
                alignment: AlignmentDirectional.topCenter,
                height: heightCard,
                width: widthCard / 2.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 10,
                      blurRadius: 20,
                      offset: Offset(3, 2),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'propic' + puppy.post_id.toString(),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        child: (puppy.imgPropic_fire_url == null)
                            ? Image.asset(
                                'images/puppyplaceholder.png',
                                fit: BoxFit.cover,
                              )
                            : FutureBuilder<String>(
                                future: ImageDownloadController()
                                    .getImageDownloadUrl(puppy.post_id,
                                        puppy.imgPropic_fire_url),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> propicUrlSnapshot) {
                                  if (propicUrlSnapshot.hasError) {
                                    return Text("Something went wrong " +
                                        propicUrlSnapshot.error.toString());
                                  }

                                  if (propicUrlSnapshot.connectionState ==
                                      ConnectionState.done) {
                                    propic = Image.network(
                                      propicUrlSnapshot.data.toString(),
                                      fit: BoxFit.cover,
                                      frameBuilder: (BuildContext context,
                                          Widget child,
                                          int frame,
                                          bool wasSynchronouslyLoaded) {
                                        if (wasSynchronouslyLoaded) {
                                          return child;
                                        }
                                        return AnimatedOpacity(
                                          child: child,
                                          opacity: frame == null ? 0 : 1,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.decelerate,
                                        );
                                      },
                                    );
                                    return propic;
                                  }

                                  return SpinKitCircle(
                                    size: 20,
                                    color: colorBgTeal,
                                  );
                                },
                              ),
                        height: heightCard * 0.7,
                        width: widthCard / 2.7,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
