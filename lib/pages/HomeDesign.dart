import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/models/DataClass.dart';
import 'package:mathcrush/models/PrefData.dart';
import 'package:mathcrush/models/category.dart';
import 'package:mathcrush/models/levelsPersentage.dart';
import 'package:mathcrush/pages/feed.dart';
import 'package:mathcrush/pages/quiz_options.dart';
import 'package:mathcrush/pages/settings.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:theme_provider/theme_provider.dart';
import 'home.dart';
import 'LeaderBoard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

//GetPrefData gData = GetPrefData();
prefMainModel mainPref = prefMainModel();

class HomeDesign extends StatefulWidget {
  // final VoidCallback signOut;
  var data;

  // String pId;
  // final currentScore, currentLevel;
  // HomeDesign({this.signOut, this.pId, this.currentScore, this.currentLevel});
  @override
  HomeDesignState createState() => HomeDesignState();
}

// SingleTickerProviderStateMixin is used for animation
class HomeDesignState extends State<HomeDesign>
    with SingleTickerProviderStateMixin {
  // String pId;
  Data da = Data();
  // HomeDesignState({this.pId});

  // The app's "state".

  // Create a tab controller
  TabController controller;
  String MainName, MainMobile, MainEmail, MainPId, _id;
  String MainCurrentLevel, MainCurrentScore, MainPhotoUrl;
  Map<String, String> MainData = {};
  List abc;
  PageController _myPage;

  final _key = new GlobalKey<FormState>();
//  @override
//  bool get wantKeepAlive => true;
// bool isLoading=true;

  int _counter = 0;
  // var db = Mysql();
  var mail = '';
  var col = 0;

  @override
  void initState() {
//    data();
    // _getCustomer();
    SystemChrome.setEnabledSystemUIOverlays([]);
    getPref();
    _myPage = PageController(initialPage: 0);
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setEnabledSystemUIOverlays([]);

    // fetchData();
  }

  callToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getPref() {
    FirePref.getFireMainPref().then((value) {
      // print(value.MainPId);
      if (value.MainName != null) {
        setState(() {
          mainPref = value;
        });
      } else {
        snake(
            context: context,
            message: "Something went Wrong..Please Try Again later");
        Future.delayed(const Duration(seconds: 1), () {
          // print("Alert >>>>>>>>>>>>>>>>>>>> NO Data ");
          logOut(context);
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
//    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // //   if(data != null){
    // //   setState(() {
    // //   isLoading = false;
    //   print(data);
    // //   });
    // // }
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    setState(() {
      MainData = {
        "MainPId": mainPref.MainPId,
        "MainEmail": mainPref.MainEmail,
        "MainName": mainPref.MainName,
        "MainPhotoUrl": mainPref.MainPhotoUrl,
        "MainCurrentLevel": mainPref.MainCurrentLevel.toString(),
        "MainMobile": mainPref.MainMobile,
        "MainCurrentScore": mainPref.MainCurrentScore.toString(),
        "MainPin": mainPref.MainPin,
        "MainState": mainPref.MainState,
        "Quali": mainPref.quali,
        "About": mainPref.about
      };
//      print("ID is :${_mainPref.Mainid}");
    });

    return ThemeConsumer(
      child: Scaffold(
        key: _key,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueGrey[900],
          // color: const Color(0xFF6739b7),

          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.only(bottom: 5.0),

//          color: Colors.black,

            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 25.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.home),
                  color: col == 0 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(0);
                    });
                  },
                ),
                IconButton(
                  iconSize: 25.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(Icons.photo_filter),
                  color: col == 1 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(1);
                    });
                  },
                ),
                IconButton(
                  iconSize: 25.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.developer_board),
                  color: col == 2 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(2);
                    });
                  },
                ),
                IconButton(
                  iconSize: 25.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(Icons.settings),
                  color: col == 3 ? Colors.orange[800] : Colors.white,
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(3);
                    });
                  },
                )
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _myPage,

          scrollDirection: Axis.horizontal,
          onPageChanged: (int) {
            setState(() {
              col = int;
            });
            // print("int is $int");
            // print(col);
          },

          children: <Widget>[
            Center(
              child: DashBoard(
                pId: mainPref.MainPId,
                currentLevel: mainPref.MainCurrentLevel,
                currentScore: mainPref.MainCurrentScore,
              ),
            ),
            Center(
              child: Container(
                child: Container(
                  child: Container(child: Feed()),
                ),
              ),
            ),
            Center(
              child: Container(child: LeaderBoard()),
            ),
            Center(
              child: Container(child: settings(MainData)),
            )
          ],
          // physics:
          //     NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        ),
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: FloatingActionButton(
//              backgroundColor: Colors.red,
                  onPressed: () {
                    // Dia(
                    //   context: context,
                    // );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(
                          pId: mainPref.MainPId,
                          compliteLevel: mainPref.MainCurrentLevel,
                          currentScore: mainPref.MainCurrentScore,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Start",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  )
//              Text(
//              "Let's Go",
//              style: TextStyle(fontSize: 11.0),
//            )
//              Icon(
//                Icons.play_arrow,
////                color: Colors.white,
//              ),
                  // elevation: 5.0,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget DashBoard(
      {BuildContext context, String pId, int currentLevel, int currentScore}) {
    SystemChrome.setEnabledSystemUIOverlays([]);

// print(widget.data);
    var levelsComplite;
    bool isLoading = true;
    var earnings;
    Color text;

    // if (data != null) {
    if ((currentLevel != null) && (currentScore != null)) {
      setState(() {
        isLoading = false;
//        print("HO ");
        // print("Sree ..................$data");

        // userId = id;
        // currentLevel = int.parse(data[0]['current_level']) - 1;
        // currentScore = currentScore;
        // print(pId);
        // print(currentLevel);
        // print(levelsComplite);

        levelsComplite = currentLevel - 1;

        // earnings = currentScore;
      });
    }
    // signOut() {
    //   setState(() {
    //     widget.signOut();
    //   });
    // }

    if (isLoading == false) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                automaticallyImplyTitle: true,
                heroTag: "Hero",
                automaticallyImplyLeading: true,
                backgroundColor: Theme.of(context).dividerColor,
                largeTitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: "arial",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 30, 3, 3),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    child: CircularPercentIndicator(
                      radius: 210.0,
                      lineWidth: 18.0,
                      animation: true,
                      percent: 1.0,
                      backgroundColor: Colors.transparent,
                      animationDuration: 2300,
                      center: new Text(
                        "$levelsComplite",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60.0,
                        ),
                      ),
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: new Text(
                          "Levels Completed",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Row(
                      children: [
                        // Expanded(
                        // flex: 1,
                        // child: Container(
                        // height: 120,
                        // child: Card(
                        // shape: BeveledRectangleBorder(
                        //   borderRadius: BorderRadius.circular(
                        //     15,
                        //   ),
                        // ),
                        // elevation: 10.0,
                        // child: Center(
                        // child: Column(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Text(
                        //       '$pId',
                        //       style: TextStyle(
                        //         fontFamily: 'arial',
                        //         fontSize: 30.0,
                        //       ),
                        //     ),
                        //     Text(
                        //       'Your id',
                        //       style: TextStyle(
                        //         fontFamily: 'arial',
                        //         fontSize: 20.0,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // ),
                        // ),
                        // ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 120,
                            child: Card(
                              elevation: 0.0,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              // elevation: 10.0,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 80,
                                      child: Image.asset(
                                        "assets/images/coins.png",
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '$currentScore',
                                          style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 40.0,
                                            color: Color(
                                              0xffFF9C00,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Coins",
                                          style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      child: Card(
                        elevation: 0.0,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Levels Score",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: FutureBuilder<List>(
                      future: fetchLevels(id: pId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: new StaggeredGridView.count(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),

                              crossAxisCount: 10,
                              padding: const EdgeInsets.all(1.0),
                              children: snapshot.data.map<Widget>((item) {
                                return new ScoreCard(item);
                              }).toList(),
                              staggeredTiles: snapshot.data
                                  .map<StaggeredTile>(
                                      (_) => StaggeredTile.fit(2))
                                  .toList(),
                              mainAxisSpacing: 0.1,
                              crossAxisSpacing: 0.1, // add some space
                            ),
                          );
                        } else {
                          return Center(); // If there are no data show this
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CupertinoActivityIndicator(
          radius: 15.0,
        ),
      );
    }
  }

//   Future<List> fetchLevels(String id) async {
//     print("id is $id");
//     List list = [];
//     var map = Map<String, dynamic>();
//     map['action'] = "getLevels";
//     map['userId'] = "$id";
//     var response = await http.post(ROOT, body: map);
//     var a = json.decode(response.body);
// //    print(a);
//     for (var i = 1; i <= 1000; i++) {
//       if (a[0][i.toString()] == null) {
//       } else {
// //        print(i);
// //        print(a[0][i.toString()]);

//         list.add(levelPer(level: "$i", per: a[0][i.toString()]));
//       }
//     }

// //    print(list.length);

//     if (response.statusCode == 200) {
//       return list;
//     } else {
//       return [];
//     }
//   }
  Future<List> fetchLevels({String id}) async {
    final usersReference = Firestore.instance.collection("Users");

    List list = List();

    QuerySnapshot documentSnapshot = await usersReference
        .document(id)
        .collection("LevelPercentages")
        .orderBy('level', descending: false)
        .getDocuments();
    // .collection("Users")
    // .document(id)
    // .collection("LevelPercentages")
    // .document()
    // .get();
    // print("documentSnapshot.data.length ${documentSnapshot.documents.length}");
    documentSnapshot.documents.forEach((e) {
      levelPer levelP = levelPer.fromMap(e.data);
      list.add(levelP);
    });

    // return levelPer.fromMap(documentSnapshot);
// .document(id)
    // .collection("LevelPercentages")
    // .document(level.toString())
    // for (var row in results) {
    //   list.add(levelPer(level: row['level'], per: row['percentage']));
    // }
    // print(list);
    return List.from(list.reversed);
  }
}

class ScoreCard extends StatefulWidget {
  ScoreCard(this.ad);

  final ad;

  _ScoreCardState createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  //to keep things readable
  var _ad;
  int levelNo;
  int per;
  Color perColor;
  void initState() {
    setState(() {
      _ad = widget.ad;
      //if values are not null only we need to show them
//      levleNO = (_ad['imageUrl'] != '')
//          ? _ad['imageUrl']
//          : 'https://uae.microless.com/cdn/no_image.jpg';
      levelNo = (_ad.level);
      per = int.parse(_ad.per);
      per = per.round();
      // print("Per is $per");

      if (per <= 25.0) {
        perColor = Colors.red;
      } else if (per <= 50.0) {
        perColor = Colors.yellow;
      } else if (per <= 75.0) {
        perColor = Colors.blue;
      } else if (per <= 100.0) {
        perColor = Colors.green;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Category cata = Category(levelNo, levelNo.toString());
        _categoryPressed(context, cata, levelNo - 1, levelNo,
            mainPref.MainCurrentScore, mainPref.MainPId);
        // print("levelNo $levelNo");
        // print("per $per");
      },
      child: Card(
        elevation: 0.0,
        semanticContainer: false,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 5.0,
                  animation: true,
                  percent: per / 100,
                  backgroundColor: Colors.transparent,
                  animationDuration: 1500,
                  center: new Text(
                    "$per" + " %",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  footer: SizedBox(
                    height: 2.0,
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: perColor,
                ),
              ),
              Text("$levelNo"),
            ],
          ),
        ),
      ),
    );
  }
}

_categoryPressed(BuildContext context, Category category, int complite_level,
    int corret_level, int correntScore, var pId) {
  int com_level = complite_level;
  int co_Score = correntScore;
  int crt_level = corret_level;
  var p_Id = pId;

  // print(">>>>> $com_level");
  // print(">>>>> $co_Score");
  // print(">>>>> $crt_level");

  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => BottomSheet(
      builder: (_) {
        return ThemeConsumer(
          child: QuizOptionsDialog(
            category: category,
            cScore: co_Score,
            cLevel: com_level,
            corret_level: crt_level,
            p_Id: p_Id.toString(),
          ),
        );
      },
      onClosing: () {},
    ),
  );
}
