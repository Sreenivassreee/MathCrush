// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class Consts {
//   Consts._();

//   static const double padding = 16.0;
//   static const double avatarRadius = 66.0;
// }
// class CoinGet extends StatefulWidget {
//   @override
//   _CoinGet createState() => new _CoinGet();
// }

// class _CoinGet extends State<CoinGet> {
//   int _coins = 0;
//   UserSession userSession;
//   String userId="";
//   InterstitialAd _interstitialAd;
//   ProgressDialog pr;
//   bool _isRewardedAdReady;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     userSession=new UserSession(context);

//     getuserCoin();
//     FirebaseAdMob.instance.initialize(appId: AdManager.appId);
//     RewardedVideoAd.instance.listener = _onRewardedAdEvent;

// //    RewardedVideoAd.instance.listener =
// //        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
// //      print("RewardedVideoAd event $event");
// //      if (event == RewardedVideoAdEvent.rewarded) {
// //        setState(() {
// //          _coins += rewardAmount;
// //        });
// //      }
// //    };
//   }

//   Future getuserCoin() async{
//     SharedPreferences spre = await SharedPreferences.getInstance();
//     setState(() {

//       userId=spre.getString("useId");
//       _coins=int.parse(spre.getString("usercoin"));
//     });

//   }
//   Future updateCoin() async {
//     pr.show();
//     Fluttertoast.showToast(
//         msg: "We are updating your coins please wait... ",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Color(0xFF191919),
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
//     Map<String, String> body = {"user_id":userId,"poem_coin":_coins.toString()};
//     addCoinData("add-reward-coin", body).then((value) {

//       setState(() {
//           userSession.setUserCoin(value['data']['usercoin']);
//           _coins=int.parse(value['data']['usercoin']);
//         // homeCatList=parsePhotos(value['Catdata'].toString());
//       });
//       pr.hide();
//     });
//   }
//   @override
//   void dispose() {
//     // COMPLETE: Dispose BannerAd object

//     // COMPLETE: Dispose InterstitialAd object
//     _interstitialAd?.dispose();
//     // COMPLETE: Remove Rewarded Ad event listener
//     RewardedVideoAd.instance.listener = null;

//     super.dispose();
//   }
//   void _onRewardedAdEvent(RewardedVideoAdEvent event,
//       {String rewardType, int rewardAmount}) {
//     switch (event) {
//       case RewardedVideoAdEvent.loaded:
//         setState(() {
//           _isRewardedAdReady = true;

//         });
//         Fluttertoast.showToast(
//             msg: "loaded a rewarded ad.. ",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Color(0xFF191919),
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//         pr.hide();
//         break;
//       case RewardedVideoAdEvent.closed:
//         setState(() {

//           _isRewardedAdReady = false;
//         });
//         Fluttertoast.showToast(
//             msg: "close rewarded ad.. ",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Color(0xFF191919),
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//         _loadRewardedAd();
//         break;
//       case RewardedVideoAdEvent.failedToLoad:
//         setState(() {
//           _isRewardedAdReady = false;

//         });
//         pr.hide();
//         Fluttertoast.showToast(
//             msg: "Failed to load a rewarded ad.. ",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Color(0xFF191919),
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//         print('Failed to load a rewarded ad');
//         break;
//       case RewardedVideoAdEvent.rewarded:
//         pr.hide();
//               setState(() {
//           _coins += rewardAmount;
//           updateCoin();
//         });
//         break;
//       default:
//       // do nothing
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

//     pr.style(
//       message:
//       'Please Wait ...',

//       borderRadius: 10.0,
//       backgroundColor: Color(0xFF191919),
//       elevation: 10.0,
//       insetAnimCurve: Curves.easeInOut,
//       progress: 0.0,
//       progressWidgetAlignment: Alignment.center,
//       maxProgress: 100.0,
//       progressTextStyle: TextStyle(
//           color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
//       messageTextStyle: TextStyle(
//           color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600),
//     );
//     // TODO: implement build
//     return new Scaffold(
//         backgroundColor: AppTheme.primary,
//         body: SingleChildScrollView(
//             child: Container(
//           child: Column(
//             children: <Widget>[
//               AppBar(
//                 backgroundColor: AppTheme.AppBarColor,
//                 elevation: 0,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color:Color(0xFFFFFFFF),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: <Widget>[
//                       Stack(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.only(
//                             top: Consts.avatarRadius + Consts.padding,
//                             bottom: Consts.padding,
//                             left: Consts.padding,
//                             right: Consts.padding,
//                           ),
//                           margin: EdgeInsets.only(top: Consts.avatarRadius),
//                           decoration: new BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xFF0f0f0f),
//                                 Color(0xFF0f0f0f),
//                                 Color(0xFF0f0f0f),
//                               ],
//                             ),
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(Consts.padding),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 10.0,
//                                 offset: const Offset(0.0, 10.0),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min, // To make the card compact
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.all(0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,

//                                   children: <Widget>[

//                                     Align(
//                                       alignment: Alignment.center,
//                                       child:  Text(
//                                         '$_coins',
//                                         style: TextStyle(
//                                             color:  Color(0xFFFFD949),
//                                             fontFamily: 'Comfortaa',
//                                             fontSize: 35.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     )

//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 16.0),
//                               Text(
//                                 "If you want to add reward coin you need see the reward video for watching the reward video just click on show video button",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontFamily: 'Comfortaa',
//                                   fontWeight: FontWeight.bold,
//                                   color:Colors.white,
//                                   fontSize: 25.0,
//                                 ),
//                               ),
//                               SizedBox(height: 24.0),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: Column(
//                                   children: <Widget>[

//                                     RaisedButton(
//                                       color:  Color(0xFF191919),

//                                       onPressed: () {
//                                         _loadRewardedAd();
//                                         //Navigator.of(context).pop();
//                                       },
//                                       child: Text(
//                                         'LOAD REWARDED VIDEO',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,fontFamily: 'ui-sans-serif'),
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     RaisedButton(
//                                       color:  Color(0xFF191919),

//                                       onPressed: () {
//                                         RewardedVideoAd.instance.show();
//                                       },
//                                       child: Text(
//                                         'SHOW REWARDED VIDEO',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,fontFamily: 'ui-sans-serif'),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(

//                           top: 20,
//                           left: 50,
//                           right: 50,

//                           child:  Align(
//                             alignment: Alignment.center,
//                             child: Container(
//                                 width: 100.0,
//                                 height: 100.0,
//                                 decoration: BoxDecoration(

//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color(0xFF161414),
//                                         Color(0xFF110b0b),
//                                         Color(0xFF211c1c),
//                                       ],
//                                     ),

//                                     image: DecorationImage(
//                                         image: AssetImage('assets/images/handcoin.png'),
//                                         fit: BoxFit.cover),
//                                     borderRadius: BorderRadius.all(Radius.circular(100.0)),
//                                     boxShadow: [
//                                       BoxShadow(blurRadius: 7.0,

//                                         color: Color(0xFF110b0b),
//                                       )
//                                     ])),
//                           ),
//                         ),
//                       ],
//                     ),
// //                    RaisedButton(
// //                      child: const Text('SHOW REWARDED VIDEO'),
// //                      onPressed: () {
// //                        RewardedVideoAd.instance.show();
// //                      },
// //                    )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )));
//   }

//   void _loadRewardedAd() {
//     pr.show();
//     RewardedVideoAd.instance.load(
//       targetingInfo: MobileAdTargetingInfo(),
//       adUnitId: AdManager.rewardedAdUnitId,
//     );
//   }
// }
