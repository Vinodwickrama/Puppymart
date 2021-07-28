import 'dart:io';

import 'package:flutter/material.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/view/post_add_screen_4.dart';

import '../constant.dart';

class PostAddScreen3 extends StatelessWidget {
  final Puppy puppy;
  PostAddScreen3(this.puppy);

  String _country;
  String _city;
  String _district;
  String _town;
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Location Details',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Please Select the Country',
                  style: textStyleTitle.copyWith(
                    color: colorBgTeal,
                    fontSize: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 100 + _screenHeight / 8,
                  margin: EdgeInsets.all(10),
                  child: ListWheelScrollView(
                    useMagnifier: true,
                    overAndUnderCenterOpacity: 0.5,
                    physics: FixedExtentScrollPhysics(),
                    magnification: 1.3,
                    itemExtent: 50,
                    children: <Widget>[
                      Text(
                        'Sri Lanka',
                        style: textStyleTitle,
                      ),
                      Text(
                        'India',
                        style: textStyleTitle,
                      ),
                      Text(
                        'United States',
                        style: textStyleTitle,
                      ),
                      Text(
                        'United Kingdom',
                        style: textStyleTitle,
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
              'Please Enter the District, City and Town',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'District',
                        style: textStyleDistance.copyWith(
                          color: colorBgTeal,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          style: textStyleDistance.copyWith(
                            color: colorBgTeal,
                            fontSize: 15,
                          ),
                          onChanged: (value) {
                            _district = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'City',
                        style: textStyleDistance.copyWith(
                          color: colorBgTeal,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          style: textStyleDistance.copyWith(
                            color: colorBgTeal,
                            fontSize: 15,
                          ),
                          onChanged: (value) {
                            _city = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Town',
                        style: textStyleDistance.copyWith(
                          color: colorBgTeal,
                          fontSize: 15,
                          textBaseline: TextBaseline.ideographic,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            style: textStyleDistance.copyWith(
                              color: colorBgTeal,
                              fontSize: 15,
                            ),
                            onChanged: (value) {
                              _town = value;
                            }),
                      ),
                    ],
                  ),
                ],
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
                puppy.district = _district;
                puppy.city = _city;
                puppy.town = _town;
                puppy.post_id = '0000123';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PostAddScreen4(puppy);
                  }),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
