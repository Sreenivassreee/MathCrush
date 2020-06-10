import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/models/ChartModels.dart';
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

  _QuizFinishedPageState(this.p_Id);

  var _Score;
  int displaycoins = 0;

  @override
  Widget build(BuildContext context) {
    /// Create one series with sample hard coded data.

    print(widget.cScore);
    print(widget.cLevel);
    print(widget.corret_level);
    print("Q finish $p_Id");

    int correct = 0;
    this.widget.answers.forEach(
      (index, value) {
        if (this.widget.questions[index].correctAnswer == value) correct++;
      },
    );
    final TextStyle titleStyle = TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500);

    setState(
      () {
        _Score = correct / widget.questions.length * 100;
      },
    );

    if (widget.cLevel == widget.corret_level) {
      print(p_Id);
      print(correct);
      print("General");

      displaycoins = displaycoins + correct * 5;
    } else {
      displaycoins = displaycoins + correct * 2;
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

    return NestedScrollView(
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
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: 300,
                    width: 300,
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
                    padding: const EdgeInsets.all(20.0),
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
                                              color: Colors.green),
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
                                          '$displaycoins',
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
                        SizedBox(height: 1.0),
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
                        SizedBox(height: 20.0),
                        Center(
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 40,
                            child: RaisedButton(
                              color: Colors.red,
                              child: new Text(
                                "Check Answers to submit",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ThemeConsumer(
                                      child: CheckAnswersPage(
                                        noOfCorrectAnswers: correct,
                                        percentage: _Score,
                                        questions: widget.questions,
                                        answers: widget.answers,
                                        NeedUpScore: widget.cScore,
                                        NeedUpLevel: widget.cLevel,
                                        corret_level: widget.corret_level,
                                        p_Id: widget.p_Id,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
