import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:mathcrush/Services/Firebase.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/pages/HomeDesign.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/pages/google_signin.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  String id;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    checkNetWork();
  }

  // checkUserFromDataBase() async {
  // String _mess;
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var id = preferences.getString("id");
//     print("id is $id");
//     if (id != null) {
//       try {
//         await Fire.fireBaseUserData(id: id, context: context).then((_value) {
//           print("fireBaseUserData $_value");
//           if (_value != null) {
//             FirePref.initialFirebasePrefSave(_value).then((value3) {
//               if (value3 == "Sucess") {
//                 _mess = "Sucess";
//               }
//             });
//           } else {
//             print("Empty");
//             logOut(context);
//             _mess = "F";
// //
//           }
//         });
//       } catch (e) {
//         ErrorPage(context: context, message: "Try Again");
//         print(e);
//         _mess = "F";
//       }
//     }
  // return _mes?s;
  // }

  checkNetWork() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isLogin = preferences.getString("ISLOGIN");
    var id = preferences.getString("id");

    // print(isLogin);
    // print(id);

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (isLogin == "TRUE") {
        // print("id is $id");
        if (id != null) {
          try {
            Fire.fireBaseUserData(id: id, context: context).then((_value) {
              // print("fireBaseUserData $_value");
              if (_value != null) {
                FirePref.initialFirebasePrefSave(_value).then((value3) {
                  if (value3 == "Sucess") {
                    sleep(const Duration(microseconds: 500));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ThemeConsumer(
                          child: HomeDesign(),
                        ),
                      ),
                    );
                  } else {
                    logOut(context);
                  }
                });
              } else {
                // print("Empty");
                logOut(context);
              }
            });
          } catch (e) {
            ErrorPage(context: context, message: "Try Again");
            print(e);
          }
        } else {
          logOut(context);
        }

        // if (value == "Succes") {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => ThemeConsumer(
        //         child: HomeDesign(),
        //       ),
        //     ),
        //   );
        // } else {
        //   logOut(context);
        // }

      } else {
        sleep(const Duration(microseconds: 500));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ThemeConsumer(
              child: GoogleWithLogin(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/intro2.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                width: 150,
                margin: EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/steve.png",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
