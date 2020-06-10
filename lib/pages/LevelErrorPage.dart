// import 'package:flutter/material.dart';
// import 'package:theme_provider/theme_provider.dart';

// class LevelErrorPage extends StatelessWidget {
//   final String message;

//   const LevelErrorPage({Key key, this.message = "There was an unknown error."})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ThemeProvider(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Hey Your Not Allowd'),
//           elevation: 0,
//         ),
//         body: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Center(
//               child: Center(
//                 child: Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
