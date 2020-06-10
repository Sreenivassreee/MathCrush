import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathcrush/Animation/FadeAnimation.dart';
import 'package:mathcrush/Services/Firebase.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/models/PrefData.dart';
import 'package:mathcrush/models/alreadyDataFromServer.dart';
import 'package:mathcrush/pages/HomeDesign.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/resources/Global.dart';

class GoogleWithLogin extends StatefulWidget {
  @override
  _GoogleWithLoginState createState() => _GoogleWithLoginState();
}

class _GoogleWithLoginState extends State<GoogleWithLogin> {
  // AuthService auth = AuthService();
  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  bool _isLoggedIn = false;
  // GoogleSignInAccount currentUser;
  alreadyDataFromServer serverUserData = alreadyDataFromServer();
  prefMainModel mainprefData = prefMainModel();

  bool isLoading = false;
  bool netStatus;
  final GoogleSignIn _googleSignIn2 =
      GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    // setState(() {
    // _currentUser = account;

    checkNetWork(context).then((value) {
      print("NetworkValue is $value");
      if (value == "Pass") {
        // CheckUserFromDataBase();
        // Pref.saveLoginStatusPrif();
      } else {
        // ErrorPage(context: context);
        // logOut(context);
        // Pref.saveLoginStatusPrifFalse();
      }
    });
    // });
//      if (_currentUser != null) {
//        Navigator.of(context).pushReplacement(
//          MaterialPageRoute(
//            builder: (BuildContext context) => HomeDesign(),
//          ),
//        );
//      }
    // });
    // _googleSignIn.signInSilently();
  }

  checkUserFromDataBase(_user) async {
    try {
      await Fire.initialCheck(user: _user, context: context).then((_value) {
        print("_value $_value");
        // print("Status :${value.uStatus}");
        if (_value != null) {
          print(" _value is $_value");
          checkNetWork(context).then(
            (value) {
              print("NetworkValue is $value");
              if (value == "Pass") {
                FirePref.initialFirebasePrefSave(_value).then(
                  (value3) {
                    if (value3 == "Sucess") {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeDesign(),
                        ),
                      );
                    }
                  },
                );
              } else {
                ErrorPage(context: context);
                logOut(context);

                // Pref.saveLoginStatusPrifFalse();
              }
            },
          );
        } else {
          logOut(context);
//
        }
      });
    } catch (e) {
      ErrorPage(context: context, message: e);
      logOut(context);
    }
  }

  // Future<FirebaseUser> login() async {
  //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   GoogleSignInAuthentication gsa = await googleSignInAccount.authentication;
  //   FirebaseUser user = await _googleSignIn.isSignedIn();
  //       idTocken: gsa.idToken, accessTocken: gsa.accessToken);
  // }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser user;
    bool isSignedIn = await _googleSignIn2.isSignedIn();
    if (isSignedIn) {
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn2.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      user = (await _auth.signInWithCredential(credential)).user;

      // print(user.gmailId);
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser currentUser = await _handleSignIn();
    checkUserFromDataBase(currentUser);
    Pref.saveLoginStatusPrif();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => HomeDesign(
    //         //  user, _googleSignIn
    //         ),
    //   ),
    // );
  }

  // Future<void> _login() async {
  //   String _mess;
  //   try {
  //     await _googleSignIn.signIn().then((value) {
  //       setState(
  //         () {
  //           _mess = "Sucess";
  //           _isLoggedIn = true;
  //         },
  //       );
  //     });
  //   } catch (err) {
  //     setState(() {
  //       _isLoggedIn = false;
  //     });

  //     ErrorPage(context: context, message: err.toString());

  //     logOut(context);

  //     print(err);
  //   }
  //   return _mess;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900],
              Colors.orange[800],
              Colors.orange[400]
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Hello ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'arial',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "There",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'arial',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                          1.4,
                          Stack(
                            children: [
                              Container(
                                height: 400,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: SvgPicture.asset(
                                  "assets/images/signup.svg",
                                  height: 500,
                                  width: 500,
                                ),
                              ),
                              _isLoggedIn
                                  ? Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 200),
                                        child: Center(
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              strokeWidth: 6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2.5,
                          Container(
                            height: 80,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange[900]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: FlatButton.icon(
                                  icon: Icon(FontAwesomeIcons.google,
                                      color: Colors.white),
                                  onPressed: () async {
                                    checkNetWork(context).then(
                                      (value) {
                                        print("NetworkValue is $value");
                                        if (value == "Pass") {
                                          onGoogleSignIn(context);
                                          // _login();
                                          setState(
                                            () {
                                              // _isLoggedIn == true;
                                            },
                                          );
                                        }
                                      },
                                    );
                                  },
                                  label: Expanded(
                                    child: Text(
                                      'LOGIN WITH GOOGLE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: _isLoggedIn == false
//           ? Center(
//               child: Container(
//                 padding: EdgeInsets.all(30),
//                 decoration: BoxDecoration(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FlutterLogo(
//                       size: 150,
//                     ),
//                     Text(
//                       'Login to Start',
//                       textAlign: TextAlign.center,
//                     ),
//                     FlatButton(
//                       color: Colors.red,
//                       child: Icon(Icons.person),
    // onPressed: () {
    // checkNetWork(context).then(
    //   (value) {
    //     print("NetworkValue is $value");
    //     if (value == "Pass") {
    //       _login();
    //       setState(
    //         () {
    //           _isLoggedIn == true;
    //         },
    //       );
    //     }
    //   },
    // );
//                       },
//                     ),
// //              LoginButton(
// //                text: 'LOGIN WITH GOOGLE',
// //                icon: FontAwesomeIcons.google,
// //                color: Colors.black45,
// //                loginMethod: () => _login(),
// //              ),
//                     //  LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin)
//                   ],
//                 ),
//               ),
// //                    LoginButton(), // <-- Built with StreamBuilder
// //                    UserProfile() // <-- Built with StatefulWidget
//             )
//           : Container(
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   Center(
//                     child: Container(
//                         height: 70,
//                         width: 70,
//                         child: CupertinoActivityIndicator(
//                           radius: 40.0,
//                         )),
//                   ),
//                   Text(
//                     "Setting Up For You...",
//                     style: TextStyle(color: Colors.green, fontSize: 20.0),
//                   ),
//                   Text(
//                     "Plese Wait Dont Quit",
//                     style: TextStyle(color: Colors.green, fontSize: 15.0),
//                   )
//                 ],
//               ),
//             ),
//     );
  }
}
