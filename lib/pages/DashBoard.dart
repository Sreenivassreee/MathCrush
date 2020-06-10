//import 'package:flutter/material.dart';
//
//class DashBoard extends StatefulWidget {
//  // List data;
//  String pId;
//  var currentScore, currentLevel;
//  final VoidCallback signOut;
//
//  DashBoard({this.pId, this.currentLevel, this.currentScore, this.signOut});
//  @override
//  _DashBoardState createState() => _DashBoardState(
//      // data: data,
//      pId,
//      currentScore,
//      currentLevel);
//}
//
//class _DashBoardState extends State<DashBoard> {
//  // List data;
//  String id;
//  var cScore, cLevel;
//
//  _DashBoardState(this.id, this.cScore, this.cLevel);
//
//  bool isLoading = true;
//  var earnings;
//  var userId;
//  int levelsComplite;
//  String pId;
//  var currentScore, currentLevel;
//
//  @override
//  void initState() {
//    setState(() {
//      pId = id;
//      currentScore = cScore;
//      currentLevel = cLevel;
//    });
//    super.initState();
//  }
//
//  Widget build(BuildContext context) {
//// print(widget.data);
//
//    // if (data != null) {
//
//    if ((currentLevel != null) && (currentScore != null)) {
//      setState(() {
//        isLoading = false;
//        // print("Sree ..................$data");
//
//        // userId = id;
//        // currentLevel = int.parse(data[0]['current_level']) - 1;
//        // currentScore = currentScore;
//        levelsComplite = int.parse(currentLevel) - 1;
//
//        earnings = int.parse(currentScore) / 10;
//      });
//    }
//    signOut() {
//      setState(() {
//        widget.signOut();
//      });
//    }
//
//    if (isLoading == false) {
//      return Scaffold(
////          appBar: AppBar(
////            title: Text("DashBoard"),
////            actions: <Widget>[
////              IconButton(
////                onPressed: () {
////                  signOut();
////                },
////                icon: Icon(Icons.lock_open),
////              )
////            ],
////          ),
//
//        body: Padding(
//          padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
//          child: Column(
//            children: <Widget>[
//              Card(
//                elevation: 10.0,
//                child: Padding(
//                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//                  child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Text('Your Id',
//                            style:
//                                TextStyle(color: Colors.white, fontSize: 23)),
//                        SizedBox(
//                          height: 15,
//                        ),
//                        Text(
//                          '$pId',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 18.0,
//                          ),
//                        ),
//                      ]),
//                ),
//              ),
//              SizedBox(
//                height: 7,
//              ),
//              Card(
//                elevation: 10.0,
//                child: Padding(
//                  padding: EdgeInsets.fromLTRB(24, 10, 24, 12),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Text('Levels Complited',
//                              style: TextStyle(
//                                  color: Colors.blueAccent, fontSize: 23)),
//                          SizedBox(
//                            height: 15,
//                          ),
//                          Text('$levelsComplite',
//                              style: TextStyle(
//                                  color: Colors.white, fontSize: 50.0)),
//                          Container()
//                        ],
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(1.0),
//                        child: Material(
//                          color: Colors.red,
//                          shape: CircleBorder(),
//                          child: Center(
//                            child: Padding(
//                              padding: const EdgeInsets.all(28.0),
//                              child: Icon(Icons.timeline,
//                                  color: Colors.white, size: 30.0),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 7,
//              ),
//              Card(
//                elevation: 10.0,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Center(
//                      child: Padding(
//                        padding: const EdgeInsets.all(24.0),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Center(
//                              child: Text(
//                                'Total Points',
//                                style: TextStyle(
//                                  color: Colors.blueAccent,
//                                  fontWeight: FontWeight.w700,
//                                  fontSize: 24.0,
//                                ),
//                              ),
//                            ),
//                            SizedBox(
//                              height: 10.0,
//                            ),
//                            Center(
//                              child: Material(
//                                color: Colors.red,
//                                shape: CircleBorder(),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(16.0),
//                                  child: Icon(
//                                    Icons.score,
//                                    color: Colors.white,
//                                    size: 30.0,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            // Center(child: Text('2000', style: TextStyle(color: Colors.white,fontSize: 30.0))),
//
//                            // Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                          ],
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(24.0),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          // Material
//                          // (
//                          //   color: Colors.amber,
//                          //   shape: CircleBorder(),
//                          //   child: Padding
//                          //   (
//                          //     padding: EdgeInsets.all(16.0),
//                          //     child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
//                          //   )
//                          // ),
//                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                          // Center(child: Text('Points', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w700, fontSize: 24.0))),
//                          Center(
//                            child: Text(
//                              '$currentScore',
//                              style: TextStyle(
//                                fontFamily: 'arial',
//                                fontSize: 50.0,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              SizedBox(height: 8.0),
//              Card(
//                elevation: 10.0,
//                child: Padding(
//                  padding: const EdgeInsets.all(24.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[
//                          Center(
//                            child: Text(
//                              'Earnings',
//                              style: TextStyle(
//                                  color: Colors.blueAccent,
//                                  fontWeight: FontWeight.w700,
//                                  fontFamily: 'arial',
//                                  fontSize: 24.0),
//                            ),
//                          ),
//                          SizedBox(
//                            height: 10.0,
//                          ),
//                          Material(
//                            shape: CircleBorder(),
//                            color: Colors.red,
//                            child: Padding(
//                              padding: EdgeInsets.all(16.0),
//                              child: Icon(Icons.monetization_on),
//                            ),
//                          ),
//                        ],
//                      ),
//                      Center(
//                        child: Text(
//                          '$earnings',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 50.0,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      );
//    } else {
//      return Center(
//        child: CircularProgressIndicator(),
//      );
//    }
//  }
//}
