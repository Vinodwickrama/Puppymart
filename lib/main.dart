import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppymart/model/image_data.dart';
import 'package:puppymart/view/post_add_screen_4.dart';
import 'package:puppymart/view/puppy_ad_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puppymart/view/welcome.dart';

import 'model/puppy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageData>(
      create: (context) => ImageData(),
      child: MaterialApp(
        title: 'PuppyMart',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Welcome(),
        initialRoute: '/',
        routes: {
          '/first': (context) => Welcome(),
        },
      ),
    );
  }
}
