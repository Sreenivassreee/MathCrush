import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/Services/admob.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:mathcrush/ui/widgets/globalWidgets.dart';
import 'package:theme_provider/theme_provider.dart';
import '../models/question.dart';
import 'HomeDesign.dart';
import '../Services/Firebase.dart';
import 'package:firebase_admob/firebase_admob.dart';

class CheckAnswersPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final NeedUpScore;
  final NeedUpLevel;
  final corret_level;
  final p_Id;
  final noOfCorrectAnswers;
  final percentage;

  const CheckAnswersPage(
      {Key key,
      @required this.percentage,
      @required this.questions,
      @required this.answers,
      @required this.noOfCorrectAnswers,
      @required this.NeedUpScore,
      @required this.NeedUpLevel,
      this.corret_level,
      @required this.p_Id})
      : super(key: key);

  @override
  _CheckAnswersPageState createState() => _CheckAnswersPageState();
}

class _CheckAnswersPageState extends State<CheckAnswersPage> {
  bool isLoading = false;
  static const String testDevice = 'A293937208D4A2DC978165873AF0EB61';
  GlobalKey<FormState> _abcKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
//Banner Ads
  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       adUnitId: BannerAd.testAdUnitId,
  //       //Change BannerAd adUnitId with Admob ID
  //       size: AdSize.banner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("BannerAd $event");
  //       });
  // }

//Interstitial Ads
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
    FirebaseAdMob.instance.initialize(appId: APPID);
    //Change appId With Admob Id
    // _bannerAd = createBannerAd()
    // ..load()
    // ..show();
    super.initState();
    createInterstitialAd()
      ..load()
      ..show();
  }

  // @override
  // void dispose() {
  //   // _bannerAd.dispose();
  //   super.dispose();
  //   _interstitialAd.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
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
                'Solutions',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "arial",
                ),
              ),
            ),
          ];
        },
        body: Scaffold(
          key: _scaffoldKey,
          body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              children: <Widget>[
                // ClipPath(
                //   clipper: WaveClipperTwo(),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).scaffoldBackgroundColor,
                //     ),
                //     height: 200,
                //   ),
                // ),
                isLoading == true
                    ? Center(
                        child: Container(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(
                            strokeWidth: 7.0,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(7.0),
                        itemCount: widget.questions.length + 1,
                        itemBuilder: _buildItem,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context2, int index) {
    int _NeedUpLevel = widget.NeedUpLevel;
    int _NeedUpScore = widget.NeedUpScore;

    String _userId = widget.p_Id.toString();
    // print(widget.NeedUpLevel);
    // print(widget.corret_level);
    String Per = widget.percentage.toString();

    Per = widget.percentage.round().toString();

    if (widget.NeedUpLevel == widget.corret_level) {
      // print(_userId);
      // print(widget.noOfCorrectAnswers);
      _NeedUpLevel++;
      _NeedUpScore = _NeedUpScore + widget.noOfCorrectAnswers * 5;
    } else {
      _NeedUpScore = _NeedUpScore + widget.noOfCorrectAnswers * 2;
    }

    // print("B _NeedUpLevel : $_NeedUpLevel");

    // print("B _NeedUpScore : $_NeedUpScore");
// updatedLevel=upLevel.toString();
// updatedScore=upScore.toString();

// updatedScore=updatedScore +500;
    // print("_NeedUpLevel : $_NeedUpLevel");
    // print("_NeedUpScore : $_NeedUpScore");
//    print("corrent_level : $corret_level");
    // print("ID:   + ${widget.p_Id}");

    int _upLevel = _NeedUpLevel;
    int _upScore = _NeedUpScore;

    if (index == widget.questions.length) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width - 40,
            child: RaisedButton(
              child: new Text(
                "Finish & Go",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {
                // createInterstitialAd()..show();
                checkNetWork(context).then(
                  (value) {
                    if (value == "Pass") {
                      if (widget.NeedUpLevel == widget.corret_level) {
                        if (int.parse(Per) > 60.0) {
                          print("Up $Per");
                          Fire.fireUpdaeScoreAndLevel(
                                  _userId, _upLevel, _upScore)
                              .then(
                            (value) {
                              if (value == "Sucess") {
                                Fire.updateLevelPercentageFire(
                                        _userId, widget.corret_level, Per)
                                    .then(
                                  (_v) {
                                    if (_v == "Sucess") {
                                      Pref.saveScoringPref(_upLevel, _upScore)
                                          .then(
                                        (_value4) {
                                          if (_value4 == "Sucess") {
                                            setState(
                                              () {
                                                isLoading = false;
                                              },
                                            );
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context2) =>
                                                    ThemeConsumer(
                                                  child: HomeDesign(),
                                                ),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                            // Dia(context: context2, per: Per);
                                            congra(Per: Per);

                                            // print("added to Prif");
                                            // Dia(context: context2);
                                          } else {
                                            ErrorPage(
                                              context: context2,
                                              message:
                                                  "Your Internet Connection is Slow",
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      ErrorPage(
                                        context: context2,
                                        message:
                                            "Your Internet Connection is Slow",
                                      );
                                      logOut(context);
                                    }
                                  },
                                );
                              } else {
                                ErrorPage(
                                  context: context2,
                                  message: "Your Internet Connection is Slow",
                                );
                                logOut(context);
                              }
                            },
                          );
                        } else {
                          Dia2(
                            context: context2,
                            message:
                                "You Got $Per %, Not Eligible For Next Level,Play Again...",
                            icon: Icons.error_outline,
                            title: "Work Hard Next Time",
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
                                _userId, widget.corret_level, Per)
                            .then(
                          (_value3) {
                            if (_value3 == "Sucess") {
                              Fire.fireUpdaeScore(_userId, _upScore).then(
                                (va) {
                                  if (va == "Sucess") {
                                    Pref.saveOnlyScorePref(_upScore).then(
                                      (v) {
                                        if (v == "Sucess") {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context2) =>
                                                  ThemeConsumer(
                                                child: HomeDesign(),
                                              ),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                          congra(
                                            Per: Per,
                                            title: "Updated",
                                            dis:
                                                "${widget.noOfCorrectAnswers * 2} Coins Added",
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
                            } else {
                              ErrorPage(
                                context: context,
                                message: "Your Internet Connection is Slow",
                              );
                              logOut(context);
                            }
                          },
                        );
                      }
                    }
                  },
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(0.0),
            ),
          ),
          SizedBox(
            height: 70,
          )
        ],
      );
    }
    Question question = widget.questions[index];
    bool correct = question.correctAnswer == widget.answers[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Q :    "),
                  TextSpan(
                    text: HtmlUnescape().convert(question.question),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Your Answer :  "),
                  TextSpan(
                    text: HtmlUnescape().convert("${widget.answers[index]}"),
                    style: TextStyle(
                        color: correct ? Colors.green : Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            correct
                ? Container()
                : Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Correct Answer :  "),
                        TextSpan(
                          text: HtmlUnescape().convert(
                            question.correctAnswer,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    style: TextStyle(fontSize: 16.0),
                  )
          ],
        ),
      ),
    );
  }

  Future<Widget> congra({String Per, String title, String dis, Icon icon}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon ?? Icons.check,
                color: Colors.red,
                size: 90.0,
              ),
              Flexible(
                  child: Text(
                title ?? "Congratulations",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  dis ?? "You Got $Per %, You Promoted to Next Level",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0))),
                color: Colors.black,
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomeDesign(),
                  //   ),
                  //   (Route<dynamic> route) => false,
                  // );
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
