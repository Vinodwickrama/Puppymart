import 'dart:io';

import 'package:flutter/material.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/view/post_add_screen_3.dart';
import 'package:puppymart/view/puppy_ad_screen.dart';

enum PuppyGender { Male, Female }

class PostAddScreen2 extends StatelessWidget {
  final Puppy puppy;
  PostAddScreen2(this.puppy);

  String _breed = 'Normal';
  String _age = '1';
  String _gender = 'male';

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Enter your Ad',
          style: textStyleMainTitle.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: colorBgTeal,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Select the breed of your puppy',
              style: textStyleTitle.copyWith(
                color: colorBgTeal,
                fontSize: 18,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 110 + _screenHeight / 8,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 100 + _screenHeight / 10,
                          child: ListWheelScrollView(
                            diameterRatio: 1.5,
                            magnification: 1.3,
                            useMagnifier: true,
                            overAndUnderCenterOpacity: 0.6,
                            physics: FixedExtentScrollPhysics(),
                            itemExtent: 50,
                            onSelectedItemChanged: (value) {
                              switch (value) {
                                case 1:
                                  _breed = 'Rotweiler';
                                  break;
                                case 2:
                                  _breed = 'Golder Retreiver';
                                  break;
                                case 3:
                                  _breed = 'Street Pooch';
                                  break;
                                default:
                                  _breed = 'Normal';
                                  break;
                              }
                            },
                            children: <Widget>[
                              Text(
                                'Rotweiler',
                                style: textStyleTitle,
                              ),
                              Text(
                                'Golder Retreiver',
                                style: textStyleTitle,
                              ),
                              Text(
                                'Street Pooch',
                                style: textStyleTitle,
                              ),
                              Text(
                                'RichBack',
                                style: textStyleTitle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select the gender of your puppy',
              style: textStyleTitle.copyWith(
                color: colorBgTeal,
                fontSize: 18,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: _screenHeight / 10,
                    margin: EdgeInsets.all(10),
                    child: genderTile(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Insert the Age of your puppy',
              style: textStyleTitle.copyWith(
                color: colorBgTeal,
                fontSize: 18,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: _screenHeight / 10,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Years : ',
                              style: textStyleDistance.copyWith(
                                color: colorBgTeal,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              height: _screenHeight / 6,
                              width: _screenWidth / 4,
                              child: buildListWheelScrollView(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Months : ',
                              style: textStyleDistance.copyWith(
                                color: colorBgTeal,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              height: _screenHeight / 6,
                              width: _screenWidth / 4,
                              child: buildListWheelScrollView(),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                puppy.breed = _breed;
                puppy.gender = _gender;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PostAddScreen3(puppy);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListWheelScrollView buildListWheelScrollView() {
    return ListWheelScrollView(
      diameterRatio: 1.9,
      magnification: 1.3,
      useMagnifier: true,
      onSelectedItemChanged: (value) {},
      overAndUnderCenterOpacity: 0.6,
      physics: FixedExtentScrollPhysics(),
      itemExtent: 20,
      children: <Widget>[
        Text(
          '0',
          style: textStyleTitle,
        ),
        Text(
          '1',
          style: textStyleTitle,
        ),
        Text(
          '2',
          style: textStyleTitle,
        ),
        Text(
          '3',
          style: textStyleTitle,
        ),
        Text(
          '4',
          style: textStyleTitle,
        ),
        Text(
          '5',
          style: textStyleTitle,
        ),
        Text(
          '6',
          style: textStyleTitle,
        ),
        Text(
          '7',
          style: textStyleTitle,
        ),
        Text(
          '8',
          style: textStyleTitle,
        ),
        Text(
          '9',
          style: textStyleTitle,
        ),
        Text(
          '10',
          style: textStyleTitle,
        ),
        Text(
          '11',
          style: textStyleTitle,
        ),
      ],
    );
  }
}

class genderTile extends StatefulWidget {
  const genderTile({
    Key key,
  }) : super(key: key);

  @override
  _genderTileState createState() => _genderTileState();
}

class _genderTileState extends State<genderTile> {
  PuppyGender _puppyGender = PuppyGender.Male;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: RadioListTile(
            groupValue: _puppyGender,
            value: PuppyGender.Male,
            title: Text(
              'Male',
              style: textStyleTitle,
            ),
            onChanged: (PuppyGender value) {
              setState(() {
                _puppyGender = PuppyGender.Male;
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile(
            groupValue: _puppyGender,
            value: PuppyGender.Female,
            title: Text(
              'Female',
              style: textStyleTitle,
            ),
            onChanged: (PuppyGender value) {
              setState(() {
                _puppyGender = PuppyGender.Female;
              });
            },
          ),
        ),
      ],
    );
  }
}
