import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppymart/component/puppyCard.dart';
import 'package:puppymart/constant.dart';
import 'package:puppymart/controller/post_controller.dart';
import 'package:puppymart/model/image_data.dart';
import 'package:puppymart/model/puppy.dart';
import 'package:puppymart/service/auth_service.dart';
import 'package:puppymart/view/post_add_screen.dart';
import 'package:puppymart/view/welcome.dart';

import 'login_screen.dart';

class PuppyAdScreen extends StatefulWidget {
  static final String id = 'PuppyAdScreen';
  final List<Puppy> puppyList;
  PuppyAdScreen(this.puppyList);

  @override
  _PuppyAdScreenState createState() => _PuppyAdScreenState();
}

class _PuppyAdScreenState extends State<PuppyAdScreen>
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = false;
  double _screenHeight, _screenWidth;
  final Duration _animDuration = const Duration(milliseconds: 300);
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  String signedProPic;
  String noUserProPic = 'images/logo.png';
  String username = ' ';

  void updateUI() {
    setState(() {
      signedProPic = authService.auth.currentUser.photoURL;
    });
  }

  @override
  void initState() {
    super.initState();
    if (authService == null) {
      authService.signInWithGoogle(context, updateUI);
    }
    _animationController =
        AnimationController(vsync: this, duration: _animDuration);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_animationController);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_animationController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_animationController);
  }

  @override
  void dispose() {
    print('back press =================================>>>');
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    bool isBack;
    if (_isCollapsed) {
      setState(
        () {
          _animationController.reverse();
          _isCollapsed = !_isCollapsed;
        },
      );
      isBack = false;
    } else {
      isBack = true;
    }
    print('_onWillPop executed =================' + isBack.toString());
    return isBack;
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: colorBgTeal,
          body: Stack(
            children: [
              buildSideMenu(context),
              buildCustomScrollView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSideMenu(BuildContext context) {
    bool isLogged = false;
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 60,
          ),
          child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: (MediaQuery.of(context).size.width / 6) + 2,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage:
                            Provider.of<ImageData>(context).authProPic.image,
                        backgroundColor: Colors.white,
                        radius: MediaQuery.of(context).size.width / 6,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (AuthService().auth.currentUser != null)
                        ? Text(
                            AuthService().auth.currentUser.displayName,
                            style: textStyleTitle.copyWith(
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          )
                        : FlatButton(
                            child: Text(
                              'Sign in',
                              style: textStyleTitle.copyWith(
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return LoginScreen(context);
                              }));
                            },
                          ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Divider(
                        thickness: 2,
                        color: colorTextDrawer,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!_isCollapsed) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                          _isCollapsed = !_isCollapsed;
                        });
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Dashboard',
                          style:
                              textStyleTitle.copyWith(color: colorTextDrawer),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PostAddScreen();
                          }),
                        );
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Icon(
                          Icons.add_comment,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Post Ad',
                          style:
                              textStyleTitle.copyWith(color: colorTextDrawer),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('user clicked! ============');
                        await PostController().removeWishList('jika manna');
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Wishlist',
                          style:
                              textStyleTitle.copyWith(color: colorTextDrawer),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Messages',
                        style: textStyleTitle.copyWith(color: colorTextDrawer),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      title: Text(
                        'About',
                        style: textStyleTitle.copyWith(color: colorTextDrawer),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await authService.signOutGoogle(context);
                        await authService.auth.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Welcome();
                            },
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Icon(
                          Icons.block,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Sign Out',
                          style:
                              textStyleTitle.copyWith(color: colorTextDrawer),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  AnimatedPositioned buildCustomScrollView() {
    return AnimatedPositioned(
      duration: _animDuration,
      curve: Curves.easeInBack,
      top: 0,
      bottom: 0,
      left: _isCollapsed ? 0.5 * _screenWidth : 0,
      right: _isCollapsed ? -0.5 * _screenWidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Material(
            elevation: 8,
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'PuppyMart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorTextMain,
                      letterSpacing: 1.5,
                    ),
                  ),
                  centerTitle: true,
                  pinned: true,
                  backgroundColor: Colors.white,
                  leading: InkWell(
                    child: Icon(
                      Icons.list,
                      color: colorBgTeal,
                      size: 40,
                    ),
                    onTap: () {
                      setState(() {
                        if (!_isCollapsed) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),
                  floating: true,
                  elevation: 30,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_isCollapsed == true) {
                              _animationController.reverse();
                              _isCollapsed = false;
                            }
                          });
                        },
                        child: AbsorbPointer(
                          absorbing: _isCollapsed,
                          child: FutureBuilder<PuppyCard>(
                            future:
                                getPuppyCardWithIndex(context, index), //index
                            builder: (BuildContext context,
                                AsyncSnapshot<PuppyCard> puppyCardSnap) {
                              if (puppyCardSnap.hasError) {
                                return Text("Something went wrong " +
                                    puppyCardSnap.error.toString());
                              }

                              if (puppyCardSnap.connectionState ==
                                  ConnectionState.done) {
                                return puppyCardSnap.data;
                              }
                              if (puppyCardSnap.connectionState ==
                                  ConnectionState.waiting) {
                                return Image.asset('images/pup_wait.gif');
                              }
                              return Image.asset('images/pup_wait.gif');
                            },
                          ),
                        ),
                      );
                    },
                    childCount: widget.puppyList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<PuppyCard> getPuppyCardWithIndex(
      BuildContext context, int index) async {
    List<PuppyCard> puppyCardList = [];
    for (Puppy puppy in widget.puppyList) {
      PuppyCard newPuppy = PuppyCard(puppy);
      puppyCardList.add(newPuppy);
    }
    return puppyCardList[index];
  }
}
