import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mathcrush/models/category.dart';
import 'package:mathcrush/models/levelsPersentage.dart';
import 'package:mathcrush/pages/HomeDesign.dart';
import 'package:mathcrush/pages/quiz_options.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:theme_provider/theme_provider.dart';

class TotalScore extends StatefulWidget {
  String id;
  TotalScore({this.id});
  @override
  _TotalScoreState createState() => _TotalScoreState();
}

class _TotalScoreState extends State<TotalScore> {
  bool isLoading;
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context2, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              heroTag: "Hero",
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context2).dividerColor,
              largeTitle: Text(
                'Progress',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context2).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Container(
          child: FutureBuilder<List>(
              future: fetchLevels(id: widget.id),
              // id: pId),
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
                            (_) => StaggeredTile.fit(2),
                          )
                          .toList(),
                      mainAxisSpacing: 0.1,
                      crossAxisSpacing: 0.1, // add some space
                    ),
                  );
                } else {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  ); // If there are no data show this
                }
              }),
        ),
      ),
    );
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
    if (documentSnapshot.documents.length < 0) {
      setState(() {
        isLoading = false;
      });
    }
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
        Category cata = Category(id: levelNo, level: levelNo.toString());
        _categoryPressed(
          context,
          cata,
          levelNo - 1,
          levelNo,
          mainPref.MainCurrentScore,
          mainPref.MainPId,
        );
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
          padding: const EdgeInsets.all(1.0),
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
                    height: 1.0,
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
