import 'package:flutter/material.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/view/puppy_ad_screen.dart';
import 'package:puppymart/view/welcome.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign up',
                  style: textStyleMainTitle,
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: colorBgGrey,
                  ),
                  padding: EdgeInsets.all(30),
                  //height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          hintText: 'Email',
                          hintStyle: textStyleLogin,
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: colorBgTeal,
                        cursorWidth: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Password',
                          hintStyle: textStyleLogin,
                        ),
                        obscureText: true,
                        textAlign: TextAlign.center,
                        cursorColor: colorBgTeal,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Repeat Password',
                          hintStyle: textStyleLogin,
                        ),
                        obscureText: true,
                        textAlign: TextAlign.center,
                        cursorColor: colorBgTeal,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        child: Text(
                          'Sign up',
                          style: textStyleLogin,
                        ),
                        onPressed: () {},
                        color: colorBgTeal,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Or',
                  style: textStyleTitle,
                ),
                _signInButton(() {
                  authService.signInWithGoogle(context, () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Welcome();
                    }));
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _signInButton(Function onPressed) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () => onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("images/google_logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign up with Google',
              style: TextStyle(
                fontSize: 20,
                color: colorBgTeal,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
