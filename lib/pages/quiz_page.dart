import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/Services/admob.dart';
import 'package:theme_provider/theme_provider.dart';
import '../models/category.dart';
import '../models/question.dart';
import 'quiz_finished.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;
  final cScore;
  final cLevel, corret_level, p_Id;
  const QuizPage(
      {Key key,
      @required this.questions,
      this.category,
      this.cScore,
      this.cLevel,
      this.corret_level,
      this.p_Id})
      : super(key: key);

  @override
  _QuizPageState createState() =>
      _QuizPageState(cScore, cLevel, corret_level, p_Id);
}

class _QuizPageState extends State<QuizPage> {
  int cScore;
  int cLevel, corret_level;
  String p_Id;
  _QuizPageState(this.cScore, this.cLevel, this.corret_level, this.p_Id);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  InterstitialAd _interstitialAd;
  static const String testDevice = 'A293937208D4A2DC978165873AF0EB61';

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
          if (event == MobileAdEvent.failedToLoad) {
            _interstitialAd.load();
          } else if (event == MobileAdEvent.loaded) {
            print('interstitialAd show');
            _interstitialAd.show();
          }
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: APPID);
// APPID
    // createInterstitialAd()..load();

    // myInterstitial = buildInterstitialAd()..load();
  }

  // @override
  // void dispose() {
  //   // myInterstitial.dispose();
  //   // _interstitialAd.dispose();
  //   super.dispose();
  //   // _interstitialAd.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Question question = widget.questions[_currentIndex];

    final List<dynamic> options = question.incorrectAnswers;
    // options.add(question.correctAnswer1);
    // options.shuffle();

    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.add(question.incorrectAnswer1);
      options.add(question.incorrectAnswer2);
      options.add(question.incorrectAnswer3);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        key: _key,
        appBar: AppBar(
          backgroundColor: Theme.of(context).dividerColor,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  "${_currentIndex + 1} / ${widget.questions.length}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.picture_in_picture, color: Colors.grey),
              onPressed: () {
                print("Ad");
                createInterstitialAd()
                  ..load()
                  ..show();
              },
              focusColor: Colors.red,
            )
          ],
          title: Text(
            "No time limit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),

          // Text("Q : ${_currentIndex+1}"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  // clipper: WaveClipperTwo(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    // Theme.of(context).scaffoldBackgroundColor),
                    height: 200,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.white70,
                    //     child: Text("${_currentIndex+1}"),
                    //   ),
                    // ),
                    SizedBox(width: 26.0),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        height: 250,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Text(
                              HtmlUnescape().convert(
                                widget.questions[_currentIndex].question,
                              ),
                              // softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.blueGrey[800],
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ...options.map(
                                (option) => RadioListTile(
                                  activeColor: Colors.red,
                                  title: Text(
                                    HtmlUnescape().convert("$option"),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  groupValue: _answers[_currentIndex],
                                  value: option,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _answers[_currentIndex] = option;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Expanded(

//                    Padding(
//                      padding: const EdgeInsets.only(left: 300.0),
//                      child:
//                      FloatingActionButton.extended(
//                        backgroundColor: Colors.black,
//
//
//                        // child: Icon(Icons.arrow_downward),
//                        label: Text(
//
//                            _currentIndex == (widget.questions.length - 1)
//                                ? "Submit"
//                                : "Next",style:TextStyle(color: Colors.white),),
//                        onPressed: _nextSubmit,
//                      ),
                    // ),
//                  )
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(
              _currentIndex == (widget.questions.length - 1)
                  ? Icons.check
                  : Icons.arrow_forward,
              color: Colors.white),
          onPressed: _nextSubmit,
        ),
      ),
    );
  }

  void _nextSubmit() {
    print("Up $cLevel, $cScore");

    if (_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(
        SnackBar(
          content: Text("You must select an answer to continue."),
        ),
      );
      return;
    }
    if (_currentIndex < (widget.questions.length - 1)) {
      setState(
        () {
          _currentIndex++;
        },
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ThemeConsumer(
            child: QuizFinishedPage(
              questions: widget.questions,
              answers: _answers,
              cScore: widget.cScore,
              cLevel: widget.cLevel,
              corret_level: corret_level,
              p_Id: p_Id,
            ),
          ),
        ),
      );
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(
            "You want to quit? All your progress will be lost",
            textAlign: TextAlign.center,
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
