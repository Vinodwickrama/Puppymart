import 'dart:html';

import 'package:flutter/material.dart';
import 'package:puppymart/component/puppyCard.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/model/puppy.dart';

class WishlistScreen extends StatelessWidget {
  List<Puppy> puppyWishList = [];
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Wishlist',
          style: textStyleMainTitle.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: colorBgTeal,
      ),
      body: FutureBuilder<PuppyCard>(
        //future: getPuppyCardWithIndex(context, index), //index
        builder:
            (BuildContext context, AsyncSnapshot<PuppyCard> puppyCardSnap) {
          if (puppyCardSnap.hasError) {
            return Text(
                "Something went wrong " + puppyCardSnap.error.toString());
          }

          if (puppyCardSnap.connectionState == ConnectionState.done) {
            return puppyCardSnap.data;
          }
          if (puppyCardSnap.connectionState == ConnectionState.waiting) {
            return Image.asset('images/pup_wait.gif');
          }
          return Image.asset('images/pup_wait.gif');
        },
        initialData: PuppyCard(Puppy()),
      ),
    );
  }

  Future<PuppyCard> getPuppyCardWithIndex(
      BuildContext context, int index) async {
    List<PuppyCard> puppyCardList = [];
    for (Puppy puppy in puppyWishList) {
      PuppyCard newPuppy = PuppyCard(puppy);
      puppyCardList.add(newPuppy);
    }
    return puppyCardList[index];
  }
}
