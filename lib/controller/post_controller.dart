import 'package:firebase_auth/firebase_auth.dart';
import 'package:puppymart/controller/image_download_controller.dart';
import 'package:puppymart/controller/image_upload_controller.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/service/file_name_service.dart';
import 'package:puppymart/view/login_screen.dart';

class PostController {
  ////////////////////////////////////////////
  // Start : Impl with singleton design pattern
  static final PostController _postController = PostController._internal();

  factory PostController() {
    return _postController;
  }
  PostController._internal();

  // End : Impl with singleton design pattern
  ////////////////////////////////////////////
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  CollectionReference userData =
      FirebaseFirestore.instance.collection('user_data');

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addNewPuppyPost(BuildContext context, Puppy puppy) async {
    //posts = FirebaseFirestore.instance.collection('posts');
    User currentUser = authService.auth.currentUser;
    if (currentUser != null) {
      // Adding images
      puppy.imgPropic_fire_url = await ImageUploadController()
          .uploadFile(puppy.post_id, puppy.imgPropic_url);
      puppy.img_fire_urls = await ImageUploadController()
          .uploadManyFiles(puppy.post_id, puppy.img_urls);

      // Adding post details
      return posts
          .add(
            {
              '_post_id': FileNameService.getPostIdFromDateTime(
                  DateTime.now(), currentUser.uid),
              '_post_dateTime': DateTime.now().toString(),
              '_post_user_uid': currentUser.uid,
              '_post_user_name': currentUser.email,
              '_title': puppy.title,
              '_breed': puppy.breed,
              '_description': puppy.description,
              '_country': puppy.country,
              '_province': puppy.province,
              '_district': puppy.district,
              '_gender': puppy.gender,
              '_city': puppy.city,
              '_town': puppy.town,
              '_location': puppy.location,
              '_imgPropic_url': puppy
                  .imgPropic_fire_url, // newly assigned filename when uploading images

              '_img_urls': puppy.img_fire_urls,
              //'_price': puppy.price.toString(),
              '_price': 0.0,
              '_mobile_no': puppy.mobile_no.toString(),
              '_isNegotiable': puppy.isNegotiable.toString(),
            },
          )
          .then((value) => print(currentUser.email +
              '======== user post added successfully!' +
              'Propic ===>>> ' +
              puppy.imgPropic_fire_url))
          .catchError((error) => print("Failed to add post: $error"));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginScreen(context);
      }));
      return null;
    }
  }

  Future<List<Puppy>> loadPosts() async {
    //posts = FirebaseFirestore.instance.collection('posts');
    print('==============Load post step 01 ===========');
    List<Puppy> puppyList = [];
    await posts.get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) {
                print(doc["_breed"]); // testing line
                Puppy puppy = Puppy();
                puppy.post_id = doc["_post_id"];
                puppy.post_dateTime = doc["_post_dateTime"];
                puppy.post_user_uid = doc["_post_user_uid"];

                puppy.post_user_name = doc['_post_user_name'];
                puppy.title = doc["_title"];
                puppy.breed = doc["_breed"];
                puppy.gender = doc["_gender"];
                puppy.description = doc["_description"];
                puppy.country = doc["_country"];
                puppy.province = doc["_province"];
                puppy.district = doc["_district"];
                puppy.city = doc["_city"];
                puppy.town = doc["_town"];
                // setting image url of firestore
                //String propicFilename = doc["_imgPropic_url"];
                //mageDownloadController().getImageDownloadUrl(puppy.post_id,propicFilename);
                puppy.imgPropic_fire_url = doc["_imgPropic_url"];

                print('============Test0000=====>> ' +
                    doc["_imgPropic_url"].toString());

                puppy.img_fire_urls = List.castFrom(doc["_img_urls"]);
                //puppy.price = double.parse(doc["_price"].toString());
                puppy.mobile_no = doc["_mobile_no"];
                //puppy.isNegotiable = doc["_isNegotiable"];
                print('Testing vini : ===== > ' + puppy.toString());
                puppyList.add(puppy);
              },
            )
          },
        );
    return puppyList;
  }

  Future<void> updateUserData(User user) async {
    DocumentReference reference = users.doc(user.uid);
    await reference.set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoUrl': user.photoURL,
        'displayName': user.displayName,
        'lastSeen': DateTime.now()
      },
    );
  }

  Future<void> updateWishList(String postID) async {
    print('===updateWishList start===' + postID);
    // CollectionReference reference =
    //     users.doc(authService.auth.currentUser.uid).collection('wishlist');
    // print('===updateWishList ===' + postID);
    // await reference.add(
    //   {
    //     'post_ID': postID,
    //   },
    // );
  }

  Future<void> removeWishList(String postID) async {
    print('===removeWishList start===' + postID);
    String userID = authService.auth.currentUser.uid;
    CollectionReference wishListReference =
        users.doc(userID).collection('wishlist');
    print('===removeWishList ===' + postID);
    //   bool isPostLiked;
    //   Future<DocumentSnapshot> docSnapshot = wishListReference.get();
    //   DocumentSnapshot doc = await docSnapshot;
    //   if (doc['likedBy'].contains(userID)) {
    //     isPostLiked = true;
    //   } else {
    //     isPostLiked = false;
    //   }
    // }

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
        users.doc(userID).collection('wishlist').doc('RATIyeopWWgeQbaAYxks'),
        {'postID': postID},
      );
    });
  }
}
