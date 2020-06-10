import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathcrush/pages/intro.dart';
import 'package:theme_provider/theme_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        // AppTheme.light(),
        // AppTheme.dark(),
        customAppWhite(),
        customAppTheme(),
      ],
      child: MaterialApp(
        // data();

        debugShowCheckedModeBanner: false,
        home: ThemeConsumer(
          child: Intro(),
        ),
      ),
    );
  }
}

AppTheme customAppWhite() {
  return AppTheme(
    id: "white",
    description: "Custom Color Scheme",
    data: ThemeData(
        fontFamily: 'arial',
        primarySwatch: Colors.red,
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.indigo[50],
        // cardColor: Colors.grey[850],
//        cardColor: Color(0xFF171332),
        primaryColor: Colors.black,
        accentColor: Colors.red,
        // canvasColor: Colors.grey[50],
        applyElevationOverlayColor: true,
        disabledColor: Colors.grey,
        dividerColor: Colors.white,
        cursorColor: Colors.indigo[50],
        canvasColor: Colors.red

        // appBarTheme: AppBarTheme(
        //   color: Colors.red,

        //   elevation: 0.0,
        // accentColor: Colors.yellow,
        // primaryColor: Colors.red,
        // scaffoldBackgroundColor: Colors.yellow[200],
        // buttonColor: Colors.amber,
        // dialogBackgroundColor: Colors.yellow,
        // ),
        ),
  );
}

AppTheme customAppTheme() {
  return AppTheme(
    id: "pureblack",
    description: "Custom Color Scheme",
    data: ThemeData(
      fontFamily: 'arial',
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      cardColor: Colors.blueGrey[800],
      // cardColor: Colors.grey[850],
//        cardColor: Color(0xFF171332),
      primaryColor: Colors.white,
      bottomAppBarColor: Colors.red,
      scaffoldBackgroundColor: Colors.black,

      accentColor: Colors.red,
      canvasColor: Colors.grey[50],
      applyElevationOverlayColor: true,
      disabledColor: Colors.grey,
      cursorColor: Colors.indigo[50],
      dividerColor: Colors.black,

      // appBarTheme: AppBarTheme(
      //   color: Colors.red,

      //   elevation: 0.0,
      // accentColor: Colors.yellow,
      // primaryColor: Colors.red,
      // scaffoldBackgroundColor: Colors.yellow[200],
      // buttonColor: Colors.amber,
      // dialogBackgroundColor: Colors.yellow,
      // ),
    ),
  );
}

//     MaterialApp(
//       color: Colors.black,
//       debugShowCheckedModeBanner: false,
//       title: 'Math Quiz',
//       theme: ThemeData(
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
//       ),

//       // ThemeData(fontFamily:'arial.ttf',backgroundColor: Colors.grey[800]),
//       home: Intro(),
//     );
//   }
// }
