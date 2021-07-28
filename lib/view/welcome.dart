import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/controller/post_controller.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/view/puppy_ad_screen.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Puppy> puppyList = [];
  @override
  void initState() {
    super.initState();
    getPuppyList();
  }

  Future<void> getPuppyList() async {
    puppyList = await PostController().loadPosts();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PuppyAdScreen(puppyList);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0, -0.25),
              child: Image.asset(
                'images/logo.png',
                height: 100,
                width: 100,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.5),
              child: SpinKitChasingDots(
                color: colorBgTeal,
                size: 50.0,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.75),
              child: Text(
                'Connecting to internet...',
              ),
            )
          ],
        ));
  }
}
