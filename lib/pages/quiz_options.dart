import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathcrush/models/homeLearn.dart';
import 'package:mathcrush/pages/picture.dart';
import 'package:mathcrush/pages/youtubeVideo.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:theme_provider/theme_provider.dart';
import '../models/category.dart';
import '../models/question.dart';
import '../resources/api_provider.dart';
import '../pages/error.dart';
import '../pages/quiz_page.dart';

class QuizOptionsDialog extends StatefulWidget {
  final Category category;
  final cScore;
  final cLevel;
  final corret_level;
  final p_Id;

  const QuizOptionsDialog(
      {Key key,
      this.category,
      this.cScore,
      this.cLevel,
      this.corret_level,
      this.p_Id})
      : super(key: key);

  @override
  _QuizOptionsDialogState createState() =>
      _QuizOptionsDialogState(cScore, cLevel, corret_level, p_Id);
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int cScore, cLevel, corret_level;
  String p_Id;

  _QuizOptionsDialogState(
      this.cScore, this.cLevel, this.corret_level, this.p_Id);

  bool processing, isLoadingLearn;
  Learn learn = Learn();

  @override
  void initState() {
    super.initState();
    isLoadingLearn = true;
    getL(widget.category);
//    _noOfQuestions = 10;
//    _difficulty = "easy";
    processing = false;
  }

  getL(category) async {
    print(category);
    await getLearn(category).then((value) {
      if (value != null) {
        setState(() {
          learn = value;
          isLoadingLearn = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // _bannerAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Score :: $cScore");
    print("level :: $cLevel");

    return ThemeConsumer(
      child: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).dividerColor,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 5,
                      color: Theme.of(context).cardColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          color: Colors.black,
                        ),
                        height: 26,
                        width: double.infinity,
                        child: Text(
                          "Learn Concept",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    learn.pic != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.video,
                                      size: 40,
                                    ),
                                    onPressed: learn == null
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (
                                                  context,
                                                ) =>
                                                    ThemeConsumer(
                                                  child: Youtube(
                                                    url: learn.video,
                                                  ),
                                                ),
                                              ),
                                            );
                                            print("video there ${learn.pic}");
                                          },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Video"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.stickyNote,
                                      size: 30,
                                    ),
                                    onPressed: learn == null
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (
                                                  context,
                                                ) =>
                                                    ThemeConsumer(
                                                  child: picture(
                                                    picUrl: learn.pic,
                                                  ),
                                                ),
                                              ),
                                            );
                                            print("video there ${learn.pic}");
                                          },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Notes"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(
                            height: 70,
                            child: CupertinoActivityIndicator(
                              animating: true,
                            ),
                          ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 5,
                    color: Theme.of(context).cardColor,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: Colors.black,
                      ),
                      height: 26,
                      width: double.infinity,
                      child: Text(
                        "Level  Number : ${widget.category.level}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Are You Ready..!",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Text(
                        "No Time Limit",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  thickness: 1.6,
                  color: Colors.black,
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 7,
                            ),
                          ),
                          Text(
                            "Each question carries 5 Coins",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 7,
                            ),
                          ),
                          Text(
                            "Repeated level questions Carries 2 Coins",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 16.0,
                  spacing: 16.0,
                  children: <Widget>[],
                ),
              ),
              SizedBox(height: 20.0),
              processing
                  ? Container(
                      height: 30,
                      width: 30,
                      child: Theme(
                        data: ThemeData(
                          cupertinoOverrideTheme:
                              CupertinoThemeData(brightness: Brightness.dark),
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: 40,
                      width: 200,
                      child: RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Text(
                          "Start Quiz",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: _startQuiz,
                      ),
                    ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  // _selectNumberOfQuestions(int i) {
  //   setState(() {
  //     _noOfQuestions = i;
  //   });
  // }

  // _selectDifficulty(String s) {
  //   setState(() {
  //     _difficulty = s;
  //   });
  // }

  void _startQuiz() async {
    setState(() {
      processing = true;
    });

    try {
      List<Question> questions = await getQuestions(widget.category);
      print(learn.pic);

      questions.shuffle();
      Navigator.pop(context);
      if (questions.length < 1) {
        ErrorPage(
          message:
              "InSufficient Questions \n Our Dedicated Team is Working on it,We will update it soon...",
        );
        return;
      }
      questions.shuffle();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ThemeConsumer(
            child: QuizPage(
              questions: questions,
              category: widget.category,
              cScore: widget.cScore,
              cLevel: widget.cLevel,
              corret_level: corret_level,
              p_Id: p_Id,
            ),
          ),
        ),
      );
    } on SocketException catch (_) {
      ErrorPage(message: "Your Internet Connection is Slow", context: context);
    } catch (e) {
      print(e.message);

      checkNetWork(context).then((value) {
        if (value == "Pass") {
          ErrorPage(
            message:
                "InSufficient Questions \n Our Dedicated Team is Working on it,We will update it soon...",
            context: context,
          );
        }
      });
    }
    setState(
      () {
        processing = false;
      },
    );
  }
}
