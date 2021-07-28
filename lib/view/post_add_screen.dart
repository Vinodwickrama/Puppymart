import 'dart:io';

import 'package:flutter/material.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/controller/text_validator.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/view/post_add_screen_2.dart';
import 'package:puppymart/view/puppy_ad_screen.dart';

class PostAddScreen extends StatelessWidget {
  String title;
  String description;
  String mobile;
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    // This _onBackPressed will be called when user tap back button to cancel posting ad
    // Called within the WillPopScope
    Future<bool> _onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Are you sure?',
                style: textStyleMainTitle,
              ),
              content: Text(
                'Do you want to cancel the post?',
                style: textStyleTitle,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "NO",
                      style: textStyleDistance,
                    ),
                  ),
                ),
                SizedBox(width: 36),
                Container(
                  color: Colors.white54,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/first'),
                    child: Text(
                      "YES",
                      style: textStyleDistance,
                    ),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Post your Ad',
            style: textStyleMainTitle.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              _onBackPressed();
            },
          ),
          backgroundColor: colorBgTeal,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Please enter the title of your Ad',
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
                height: 50 + _screenHeight / 8,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      style: textStyleTitle,
                      cursorColor: colorBgTeal,
                      maxLines: 3,
                      minLines: 1,
                      initialValue: 'Nice Looking Puppy for donate!',
                      enableInteractiveSelection: true,
                      maxLength: 36,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Please enter any Description',
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
                height: 50 + _screenHeight / 8,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      style: textStyleTitle,
                      cursorColor: colorBgTeal,
                      maxLines: 30,
                      minLines: 1,
                      initialValue: 'Well trained Puppy for give away!',
                      enableInteractiveSelection: true,
                      maxLength: 500,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Please enter the mobile number',
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
                height: 50 + _screenHeight / 8,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'mobile : ',
                          style: textStyleDistance.copyWith(
                            color: colorBgTeal,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: _screenWidth / 3,
                          child: TextFormField(
                            style: textStyleTitle,
                            cursorHeight: 35,
                            cursorColor: colorBgTeal,
                            maxLines: 1,
                            minLines: 1,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter mobile number';
                              }
                              String text =
                                  TextValidator().validateMobile(value);
                              return text;
                            },
                            onChanged: (value) {
                              mobile = value;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            enableInteractiveSelection: true,
                            maxLength: 10,
                            decoration: InputDecoration(
                                fillColor: colorBgGrey,
                                focusColor: colorBgGrey,
                                errorStyle: textStyleDesc),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                  print(title + description);
                  if (mobile == null) {
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        Puppy puppy = Puppy();
                        puppy.title = title;
                        puppy.description = description;
                        puppy.mobile_no = mobile;
                        return PostAddScreen2(puppy);
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: _screenHeight / 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
