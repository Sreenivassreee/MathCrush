import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/Services/Firebase.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/models/ChartModels.dart';
import 'package:mathcrush/pages/HomeDesign.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/pages/home.dart';
import 'package:mathcrush/pages/showLevelDetails.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:mathcrush/ui/widgets/globalWidgets.dart';
import 'package:theme_provider/theme_provider.dart';
import '../models/question.dart';
import '../pages/check_answers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class QuizFinishedPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final cScore;
  final cLevel, corret_level, p_Id;

  QuizFinishedPage(
      {Key key,
      @required this.questions,
      @required this.answers,
      this.cScore,
      this.cLevel,
      this.corret_level,
      this.p_Id})
      : super(key: key);

  @override
  _QuizFinishedPageState createState() => _QuizFinishedPageState(p_Id);
}

class _QuizFinishedPageState extends State<QuizFinishedPage> {
  int correctAnswers;
  var p_Id;
  bool isLoading = false;

  _QuizFinishedPageState(this.p_Id);

  double _Score = 0.0;
  int displaycoins = 0;
  int coins = 0;
  var Perr = " ";

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    int _NeedUpLevel = widget.cLevel;
    int _NeedUpScore = widget.cScore;

    String _userId = widget.p_Id.toString();
    // print(widget.NeedUpLevel);
    // print(widget.corret_level);

    // String Per = _Score.toString();

    print("Per $Perr");
    print("_NeedUpLevel : $_NeedUpLevel");
    print("corret_level : ${widget.corret_level}");

    print(widget.cScore);
    print(widget.cLevel);
    print(widget.corret_level);
    print("Q finish $p_Id");

    this.widget.answers.forEach(
      (index, value) {
        if (this.widget.questions[index].correctAnswer == value) correct++;
      },
    );

    setState(
      () {
        _Score = correct / widget.questions.length * 100;
      },
    );

    if (widget.cLevel == widget.corret_level) {
      print(p_Id);
      print(correct);
      print("General");

      coins = displaycoins + correct * 5;
    } else {
      coins = displaycoins + correct * 2;
      print("Random");
    }

    List<charts.Series<ChartResult, String>> _createSampleData() {
      final data = [
        new ChartResult('Total', widget.questions.length),
        new ChartResult('Correct', correct),
        new ChartResult('False', widget.questions.length - correct),
      ];
      return [
        new charts.Series<ChartResult, String>(
          id: 'Results',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartResult sales, _) => sales.catagery,
          measureFn: (ChartResult sales, _) => sales.result,
          data: data,
          fillColorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        )
      ];
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              automaticallyImplyLeading: true,
              actionsForegroundColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).dividerColor,
              heroTag: "Hero",
              largeTitle: Text(
                'Results',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "arial",
                ),
              ),
            ),
          ];
        },
        body: ThemeConsumer(
          child: isLoading == true
              ? Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      strokeWidth: 7.0,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            height: 250,
                            width: 250,
                            child: new charts.BarChart(
                              _createSampleData(),
                            ),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       Theme.of(context).cardColor,
                          //       Theme.of(context).dividerColor,
                          //     ],
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //   ),
                          // ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 1),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          elevation: 0.0,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '${correct}',
                                                  style: TextStyle(
                                                      fontFamily: 'arial',
                                                      fontSize: 30.0,
                                                      color: Colors.green),
                                                ),
                                                Text(
                                                  'Correct Answers',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          elevation: 0.0,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '${widget.questions.length - correct}',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 30.0,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Wrong Answers',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          elevation: 0.0,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '${_Score.roundToDouble()}',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 30.0,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(
                                                  'Score',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          elevation: 0.0,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '$coins',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 30.0,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                Text(
                                                  'Coins You Got',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 120,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (_NeedUpLevel ==
                                                  widget.corret_level) {
                                                _NeedUpLevel++;
                                                _NeedUpScore =
                                                    _NeedUpScore + correct * 5;
                                              } else {
                                                _NeedUpScore =
                                                    _NeedUpScore + correct * 2;
                                              }
                                              Perr = _Score.round().toString();
                                              checkNetWork(context).then(
                                                (value) {
                                                  if (value == "Pass") {
                                                    if (widget.cLevel ==
                                                        widget.corret_level) {
                                                      if (int.parse(Perr) >
                                                          60.0) {
                                                        print("Up $Perr");
                                                        print(
                                                            "Need Up $_NeedUpLevel  $_NeedUpScore");
                                                        Fire.fireUpdaeScoreAndLevel(
                                                                _userId,
                                                                _NeedUpLevel,
                                                                _NeedUpScore)
                                                            .then(
                                                          (value) {
                                                            if (value ==
                                                                "Sucess") {
                                                              Fire.updateLevelPercentageFire(
                                                                      _userId,
                                                                      widget
                                                                          .corret_level,
                                                                      Perr)
                                                                  .then(
                                                                (_v) {
                                                                  if (_v ==
                                                                      "Sucess") {
                                                                    Pref.saveScoringPref(
                                                                      _NeedUpLevel,
                                                                      _NeedUpScore,
                                                                    ).then(
                                                                      (_value4) {
                                                                        if (_value4 ==
                                                                            "Sucess") {
                                                                          setState(
                                                                            () {
                                                                              isLoading = false;
                                                                            },
                                                                          );
                                                                          Navigator
                                                                              .pushAndRemoveUntil(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context2) => ThemeConsumer(
                                                                                child: HomeDesign(),
                                                                              ),
                                                                            ),
                                                                            (Route<dynamic> route) =>
                                                                                false,
                                                                          );
                                                                          // Dia(context: context2, per: Per);
                                                                          congra(
                                                                              Per: Perr);

                                                                          // print("added to Prif");
                                                                          // Dia(context: context2);
                                                                        } else {
                                                                          ErrorPage(
                                                                            context:
                                                                                context,
                                                                            message:
                                                                                "Your Internet Connection is Slow",
                                                                          );
                                                                        }
                                                                      },
                                                                    );
                                                                  } else {
                                                                    ErrorPage(
                                                                      context:
                                                                          context,
                                                                      message:
                                                                          "Your Internet Connection is Slow",
                                                                    );
                                                                    logOut(
                                                                        context);
                                                                  }
                                                                },
                                                              );
                                                            } else {
                                                              ErrorPage(
                                                                context:
                                                                    context,
                                                                message:
                                                                    "Your Internet Connection is Slow",
                                                              );
                                                              logOut(context);
                                                            }
                                                          },
                                                        );
                                                      } else {
                                                        Dia2(
                                                          context: context,
                                                          message:
                                                              "You Got $Perr %, Not Eligible For Next Level,Play Again...",
                                                          icon: Icons
                                                              .error_outline,
                                                          title:
                                                              "Work Hard Next Time",
                                                        );
                                                      }
                                                      setState(
                                                        () {
                                                          isLoading = true;
                                                        },
                                                      );
                                                    } else {
                                                      setState(
                                                        () {
                                                          isLoading = true;
                                                        },
                                                      );
                                                      Fire.updateLevelPercentageFire(
                                                              _userId,
                                                              widget
                                                                  .corret_level,
                                                              Perr)
                                                          .then(
                                                        (_value3) {
                                                          if (_value3 ==
                                                              "Sucess") {
                                                            Fire.fireUpdaeScore(
                                                                    _userId,
                                                                    _NeedUpScore)
                                                                .then(
                                                              (va) {
                                                                if (va ==
                                                                    "Sucess") {
                                                                  Pref.saveOnlyScorePref(
                                                                          _NeedUpScore)
                                                                      .then(
                                                                    (v) {
                                                                      if (v ==
                                                                          "Sucess") {
                                                                        Navigator
                                                                            .pushAndRemoveUntil(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context2) =>
                                                                                ThemeConsumer(
                                                                              child: HomeDesign(),
                                                                            ),
                                                                          ),
                                                                          (Route<dynamic> route) =>
                                                                              false,
                                                                        );
                                                                        congra(
                                                                          Per:
                                                                              Perr,
                                                                          context:
                                                                              context,
                                                                          title:
                                                                              "Updated",
                                                                          dis:
                                                                              "${correct * 2} Coins Added",
                                                                        );
                                                                      } else {
                                                                        ErrorPage(
                                                                          context:
                                                                              context,
                                                                          message:
                                                                              "Your Internet Connection is Slow",
                                                                        );
                                                                        logOut(
                                                                            context);
                                                                      }
                                                                    },
                                                                  );
                                                                } else {
                                                                  ErrorPage(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        "Your Internet Connection is Slow",
                                                                  );
                                                                  logOut(
                                                                      context);
                                                                }
                                                              },
                                                            );
                                                          } else {
                                                            ErrorPage(
                                                              context: context,
                                                              message:
                                                                  "Your Internet Connection is Slow",
                                                            );
                                                            logOut(context);
                                                          }
                                                        },
                                                      );
                                                    }
                                                  } else {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context2) =>
                                                            ThemeConsumer(
                                                          child: HomeDesign(),
                                                        ),
                                                      ),
                                                      (Route<dynamic> route) =>
                                                          false,
                                                    );
                                                    ErrorPage(
                                                      context: context,
                                                      message:
                                                          "Your Internet Connection is Slow",
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                            child: Card(
                                              color: Colors.green,
                                              shape: CircleBorder(),

                                              //  BeveledRectangleBorder(
                                              // borderRadius:
                                              //   BorderRadius.circular(
                                              // 15,
                                              // ),
                                              // ),
                                              elevation: 10.0,
                                              child: Center(
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 20.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 120,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => ThemeConsumer(
                                                    child: CheckAnswersPage(
                                                      noOfCorrectAnswers:
                                                          correct,
                                                      percentage: _Score,
                                                      questions:
                                                          widget.questions,
                                                      answers: widget.answers,
                                                      NeedUpScore:
                                                          widget.cScore,
                                                      NeedUpLevel:
                                                          widget.cLevel,
                                                      corret_level:
                                                          widget.corret_level,
                                                      p_Id: widget.p_Id,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              color: Colors.yellow,
                                              shape: CircleBorder(),
                                              // shape: BeveledRectangleBorder(
                                              //   borderRadius:
                                              //       BorderRadius.circular(
                                              //     15,
                                              //   ),
                                              // ),
                                              elevation: 10.0,
                                              child: Center(
                                                child: Text(
                                                  'Answers',
                                                  style: TextStyle(
                                                    fontFamily: 'arial',
                                                    fontSize: 20.0,
                                                    color: Colors.red,
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
                                // Container(
                                //   height: 100,
                                //   width: 130,
                                //   child: Card(
                                //     shape: BeveledRectangleBorder(
                                //       borderRadius: BorderRadius.circular(
                                //         15,
                                //       ),
                                //     ),
                                //     elevation: 0.0,
                                // child: Center(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Navigator.pushAndRemoveUntil(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context2) => ThemeConsumer(
                                //             child: HomeDesign(),
                                //           ),
                                //         ),
                                //         (Route<dynamic> route) => false,
                                //       );
                                //     },
                                // child: Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Column(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceAround,
                                //     children: [
                                //       Icon(
                                //         CupertinoIcons.refresh_thick,
                                //         size: 50.0,
                                //       ),
                                //       Text(
                                //         "Score More",
                                //         style: TextStyle(
                                //           fontSize: 15.0,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // ),
                                // ),
                                // ),
                                // ),
                                // SizedBox(height: 10.0),
                                // Column(
                                //   children: <Widget>[
                                //     Center(
                                //       child: Container(
                                //         height: 50.0,
                                //         width: MediaQuery.of(context).size.width -
                                //             60,
                                //         child: RaisedButton(
                                //           color: Colors.red,
                                //           child: new Text(
                                //             "Check Answers",
                                //             style: TextStyle(
                                //               fontSize: 20.0,
                                //             ),
                                //           ),
                                //           textColor: Colors.white,
                                //           onPressed: () {},
                                //           shape: new RoundedRectangleBorder(
                                //             borderRadius:
                                //                 new BorderRadius.circular(10.0),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(height: 10.0),
                                // Center(
                                //   child: Container(
                                //     height: 50.0,
                                //     width: MediaQuery.of(context).size.width -
                                //         60,
                                //     child: RaisedButton(
                                //       color: Colors.red,
                                //       child: new Text(
                                //         "Submit",
                                //         style: TextStyle(
                                //           fontSize: 20.0,
                                //         ),
                                //       ),
                                //       textColor: Colors.white,
                                //       onPressed: () {
                                //       shape: new RoundedRectangleBorder(
                                //         borderRadius:
                                //             new BorderRadius.circular(10.0),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            // Center(
                            //   child: Container(
                            //     height: 50.0,
                            //     width: MediaQuery.of(context).size.width - 60,
                            //     child: RaisedButton(
                            //       color: Colors.red,
                            //       child: new Text(
                            //         "Check Answers to submit",
                            //         style: TextStyle(
                            //           fontSize: 20.0,
                            //         ),
                            //       ),
                            //       textColor: Colors.white,
                            //       onPressed: () {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (_) => ThemeConsumer(
                            //               child: CheckAnswersPage(
                            //                 noOfCorrectAnswers: correct,
                            //                 percentage: _Score,
                            //                 questions: widget.questions,
                            //                 answers: widget.answers,
                            //                 NeedUpScore: widget.cScore,
                            //                 NeedUpLevel: widget.cLevel,
                            //                 corret_level: widget.corret_level,
                            //                 p_Id: widget.p_Id,
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //       shape: new RoundedRectangleBorder(
                            //         borderRadius: new BorderRadius.circular(10.0),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //       ],
                            //     ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "You want to quit ? All your progress will be lost",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Click On Submit ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            "Warning!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }
}

// class SimpleBarChart extends StatelessWidget {
//  final List<charts.Series> seriesList;
//  final bool animate;

//  SimpleBarChart(this.seriesList, {this.animate});

//  /// Creates a [BarChart] with sample data and no transition.
//  factory SimpleBarChart.withSampleData() {
//    return new SimpleBarChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }

//  @override
//  Widget build(BuildContext context) {
//    return new charts.BarChart(
//      seriesList,
//      animate: animate,
//    );
//  }

/// Create one series with sample hard coded data.
//  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//    final data = [
//      new OrdinalSales('2014', 5),
//      new OrdinalSales('2015', 25),
//      new OrdinalSales('2016', 100),
//      new OrdinalSales('2017', 75),
//    ];

//    return [
//      new charts.Series<OrdinalSales, String>(
//        id: 'Sales',
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: data,
//      )
//    ];
//  }
// }

// /// Sample ordinal data type.
// class OrdinalSales {
//  final String year;
//  final int sales;

//  OrdinalSales(this.year, this.sales);
// }
