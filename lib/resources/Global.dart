import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/pages/intro.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void FailedCase({context, message}) {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => Intro(),
    ),
  );
  _key.currentState.showSnackBar(SnackBar(
    content: Text(message),
  ));
  return;
}

Future<String> checkNetWork(BuildContext context) async {
  String _mess;
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    _mess = "Pass";
  } else {
    ErrorPage(
      context: context,
      message: "Please Check Internet Connection",
    );
    _mess = "Failed";
  }
  return _mess;
}

// void netWorkError({BuildContext context, String message}) {
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//       builder: (BuildContext context) => ErrorPage(message: message),
//     ),
//   );
// }

final scaffoldKey = GlobalKey<ScaffoldState>();

void snake({String message = "Something Wrong", BuildContext context}) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 5),
    content: Text(
      message,
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    ),
  );
  scaffoldKey.currentState.showSnackBar(snackBar);
}

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

Future<void> logOut(BuildContext context) async {
  await _googleSignIn.signOut();
  try {
    Pref.signOutPref().then(
      (value) {
        print("Value is $value");
        if (value == "Sucess") {
          Pref.saveLoginStatusPrifFalse().then((value) {
            if (value == "Sucess") {
              // ErrorPage(context: context);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (contaxt) => Intro(),
                ),
                (route) => false,
              );
            }
          });
        }
      },
    );
  } catch (err) {
    // ErrorPage(context: context, message: err);
    Pref.saveLoginStatusPrifFalse();

    print(err);
  }

// }
//  ThemeData(
//               fontFamily: 'arial',
//               brightness: Brightness.dark,
//               primarySwatch: Colors.red,
//               cardColor: Colors.blueGrey[800],
//               // cardColor: Colors.grey[850],
// //        cardColor: Color(0xFF171332),
//               primaryColor: Colors.black,
//               scaffoldBackgroundColor: Colors.black,
//               accentColor: Colors.red,
//               canvasColor: Colors.grey[50],
//               disabledColor: Colors.grey,
//               appBarTheme: AppBarTheme(
//                 elevation: 0.0,

// MaterialApp(
//   color: Colors.black,
//   debugShowCheckedModeBanner: false,
//   title: 'Math Quiz',
// //       theme:
//      ThemeData(
//         fontFamily: 'arial',
//         brightness: Brightness.dark,
//         primarySwatch: Colors.red,
//         cardColor: Colors.blueGrey[800],
//         // cardColor: Colors.grey[850],
// //        cardColor: Color(0xFF171332),
//         primaryColor: Colors.black,
//         scaffoldBackgroundColor: Colors.black,
//         accentColor: Colors.red,
//         canvasColor: Colors.grey[50],
//         disabledColor: Colors.grey,
//         appBarTheme: AppBarTheme(
//           elevation: 0.0,
//         ),
//   ),
// ),
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

loading({mess = "Loading...", time = Toast.LENGTH_LONG}) {
  Fluttertoast.showToast(
      msg: mess,
      toastLength: time == "short" ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1);
}

dialog({String addedCoins = "0", context, url}) {
  showDialog(
    context: context,
    builder: (_) => NetworkGiffyDialog(
      // key: Net,
      image: CachedNetworkImage(
        imageUrl: url,
        // "https://media.giphy.com/media/MkvZFvzHIWbRK/giphy.gif",
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      entryAnimation: EntryAnimation.TOP,
      title: Text(
        '+ $addedCoins',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w600),
      ),

      description: Text(
        'Watch More Earn More',
        style: TextStyle(
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
      onlyOkButton: true,
      onOkButtonPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}

Future<Widget> congra(
    {String Per, String title, String dis, Icon icon, context}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon ?? Icons.check,
              color: Colors.red,
              size: 90.0,
            ),
            Flexible(
                child: Text(
              title ?? "Congratulations",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
            SizedBox(
              height: 15.0,
            ),
            Flexible(
              child: Text(
                dis ?? "You Got $Per %, You Promoted to Next Level",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9.0))),
              color: Colors.black,
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => HomeDesign(),
                //   ),
                //   (Route<dynamic> route) => false,
                // );
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
