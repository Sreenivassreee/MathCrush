import 'package:connectivity/connectivity.dart';
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
      ));
  // scaffoldKey.currentState.showSnackBar(snackBar);
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
