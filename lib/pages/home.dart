import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../models/category.dart';
import './quiz_options.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  // List<BasicData> basicData;
  // List data;
  var pId;
  var currentScore, compliteLevel;

  HomePage({this.pId, this.compliteLevel, this.currentScore});

  @override
  _HomePageState createState() => _HomePageState(
      pId: pId, compliteLevel: compliteLevel, currentScore: currentScore);
}

class _HomePageState extends State<HomePage> {
  // List<BasicData> basicData;
  var currentScore, compliteLevel;

  // List data;
  var pId;

  _HomePageState({this.pId, this.compliteLevel, this.currentScore});

// _HomePageState(this.basicData);

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      // fetchData();
      // this.data;
    });

    // getdata();
  }

// void fetchData() async {
//     final response = await http.get('http://192.168.64.2/android/getCurrentData.php');

//     if (response.statusCode == 200) {
//       setState(() {
//         data = json.decode(response.body);
//       });
//     }
// print("xxxxxxxxxxxxxxxxx");
  // print(data[1]['current_level']);
//   }

  @override
  Widget build(BuildContext context) {
    if (compliteLevel != null && currentScore != null) {
      setState(() {
        isloading = false;
      });
    }

    return ThemeConsumer(
      child: Scaffold(
        // CupertinoPageScaffold(
        //   child: NestedScrollView(
        //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //       return <Widget>[
        //         CupertinoSliverNavigationBar(
        //           backgroundColor: Theme.of(context).dividerColor,
        //           automaticallyImplyTitle: true,
        //           automaticallyImplyLeading: true,
        //           actionsForegroundColor: Theme.of(context).primaryColor,
        //           heroTag: "Hero",
        //           largeTitle: Text(
        //             'Levels',
        //             style: TextStyle(
        //               color: Theme.of(context).primaryColor,
        //               fontFamily: "arial",
        //             ),
        //           ),
        //         ),
        //       ];
        //     },
        body: Stack(
          children: <Widget>[
            ClipPath(
                // clipper: WaveClipperTwo(),
                // child: Container(
                //   decoration:
                //       BoxDecoration(color: Theme.of(context).primaryColor),
                //   height: 200,
                // ),
                ),
            isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _SuccessTimeline(
                    pId: pId,
                    compliteLevel: compliteLevel,
                    currentScore: currentScore)

            // CustomScrollView(
            //     physics: BouncingScrollPhysics(),
            //     slivers: <Widget>[
            //       SliverToBoxAdapter(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 16.0,
            //             vertical: 8.0,
            //           ),
            //           // child: Text(
            //           //   "Math Quiz",
            //           //   style: TextStyle(
            //           //       color: Colors.white,
            //           //       fontWeight: FontWeight.w500,
            //           //       fontSize: 16.0),
            //           // ),
            //         ),
            //       ),
            //       SliverPadding(
            //         padding: const EdgeInsets.all(16.0),
            //         sliver: SliverGrid(
            //           gridDelegate:
            //               SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 5,
            //             childAspectRatio: 1.2,
            //             crossAxisSpacing: 5.0,
            //             mainAxisSpacing: 15.0,
            //           ),
            //           delegate: SliverChildBuilderDelegate(
            //             _buildCategoryItem,
            //             childCount: categories.length,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    // int userid=1-1;
    Category category = categories[index];
    int corret_level = 0;
    int correntScore = 0;
    var p_Id;

    int complite_level = 1;

    // setState(() {
    complite_level = compliteLevel;
    corret_level = int.parse(categories[index].level);
    correntScore = currentScore;
    p_Id = pId;

    // });
//
    print(".........correntScore...... $correntScore");
    print("........complite_level........ $complite_level");
    print(".........p_Id..... $p_Id");
    print("........corret_level...... $corret_level");

    // if (complite_level > corret_level) {
    //   return TimelineTile(
    //     alignment: TimelineAlign.center,
    //     rightChild: Container(
    //       constraints: const BoxConstraints(
    //         minHeight: 120,
    //       ),
    //       color: Colors.lightGreenAccent,
    //     ),
    //     leftChild: Container(
    //       color: Colors.amberAccent,
    //     ),
    //   );
    // }
    //   return Scaffold(
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //     body: MaterialButton(
    //       elevation: 1.0,
    //       highlightElevation: 1.0,
    //       onPressed: () => _categoryPressed(context, category, complite_level,
    //           corret_level, correntScore, p_Id),
    //       shape: new CircleBorder(),
    //       color: Colors.red,
    //       textColor: Colors.white70,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           AutoSizeText(
    //             category.level,
    //             minFontSize: 18.0,
    //             textAlign: TextAlign.center,
    //             maxLines: 1,
    //             wrapWords: false,
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // } else if (complite_level == corret_level) {
    //   return Scaffold(
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //     body: MaterialButton(
    //       elevation: 1.0,
    //       highlightElevation: 1.0,
    //       onPressed: () => _categoryPressed(context, category, complite_level,
    //           corret_level, correntScore, p_Id),
    //       shape: new CircleBorder(),
    //       color: Colors.green,
    //       textColor: Colors.white,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           AutoSizeText(
    //             category.level,
    //             minFontSize: 18.0,
    //             textAlign: TextAlign.center,
    //             maxLines: 1,
    //             wrapWords: true,
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // } else {
    //   return MaterialButton(
    //     elevation: 1.0,
    //     highlightElevation: 1.0,
    //     onPressed: () {
    //       if (corret_level > complite_level) {
    //         // Navigator.of(context).push(
    //         //   MaterialPageRoute(
    //         //     builder: (BuildContext context) => LevelErrorPage(
    //         //       message: "Your Current Level is : $complite_level",
    //         //     ),
    //         //   ),
    //         // );
    //       } else {
    //         _categoryPressed(context, category, complite_level, corret_level,
    //             correntScore, p_Id);
    //         print("hi");
    //       }
    //     },
    //     shape: new CircleBorder(),
    //     color: Colors.blueGrey[800],
    //     textColor: Colors.white,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Material(
    //           color: Colors.transparent,
    //           child: Icon(
    //             Icons.lock,
    //             color: Colors.white,
    //           ),
    //         )

    //         // AutoSizeText(
    //         //   category.level,
    //         //   minFontSize: 20.0,
    //         //   textAlign: TextAlign.center,
    //         //   maxLines: 3,
    //         //   wrapWords: false,
    //         // ),
    //       ],
    //     ),
    //   );
    // }
  }
}

_categoryPressed(
    {BuildContext context,
    Category category,
    int complite_level,
    int corret_level,
    int correntScore,
    var pId}) {
  int com_level = complite_level;
  int co_Score = correntScore;
  int crt_level = corret_level;
  var p_Id = pId;

  print(">>>>> $com_level");
  print(">>>>> $co_Score");
  print(">>>>> $crt_level");

  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => BottomSheet(
      builder: (_) {
        if (corret_level < complite_level) {
          // print(">>>>> $corret_level");
          print(">>>>> ");
          print(category.level);
          print(co_Score);
          print(com_level);
          print(crt_level);

          return ThemeConsumer(
            child: QuizOptionsDialog(
              category: category,
              cScore: co_Score,
              cLevel: com_level,
              corret_level: crt_level,
              p_Id: p_Id.toString(),
            ),
          );
        } else if (complite_level == corret_level) {
          return ThemeConsumer(
            child: QuizOptionsDialog(
              category: category,
              cScore: co_Score,
              cLevel: com_level,
              corret_level: crt_level,
              p_Id: p_Id.toString(),
            ),
          );
        } else {}
      },
      onClosing: () {},
    ),
  );
}

class _SuccessTimeline extends StatefulWidget {
  var pId;
  var currentScore, compliteLevel;

  _SuccessTimeline({this.pId, this.compliteLevel, this.currentScore});
  @override
  _SuccessTimelineState createState() => _SuccessTimelineState();
}

class _SuccessTimelineState extends State<_SuccessTimeline> {
  List<Category> cates;

  @override
  void initState() {
    cates = categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFFFCB69F).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  // _Header(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _TimelineSteps(
                            cates: cates,
                            pId: widget.pId,
                            compliteLevel: widget.compliteLevel,
                            currentScore: widget.currentScore)
                      ],
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
}

class _TimelineSteps extends StatelessWidget {
  var pId;
  var currentScore, compliteLevel;
  _TimelineSteps(
      {Key key, this.cates, this.pId, this.compliteLevel, this.currentScore})
      : super(key: key);

  final List<Category> cates;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd)
            return const TimelineDivider(
              color: Color(0xFFCB8421),
              thickness: 3,
              begin: 0.1,
              end: 0.9,
            );

          final int itemIndex = index ~/ 2;
          // print("itemIndex $itemIndex");
          final Category cate = cates[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            title: cate.title,
            subtitle: cate.message,
            isLeftAlign: isLeftAlign,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == cates.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return TimelineTile(
            alignment: TimelineAlign.manual,
            rightChild: isLeftAlign ? child : null,
            leftChild: isLeftAlign ? null : child,
            lineX: isLeftAlign ? 0.1 : 0.9,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 50,
              height: 50,
              indicatorY: indicatorY,
              indicator: _TimelineStepIndicator(
                pressed: '${cate.level}',
                pId: pId,
                compliteLevel: compliteLevel,
                currentScore: currentScore,
              ),
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFFCB8421),
              width: 3,
            ),
          );
        },
        childCount: max(0, cates.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  var pId;
  var currentScore, compliteLevel;
  final String pressed;

  _TimelineStepIndicator(
      {Key key, this.pressed, this.pId, this.compliteLevel, this.currentScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(".........correntScore...... $currentScore");
    // print("........complite_level........ $compliteLevel");
    // print(".........p_Id..... $pId");
    // print("........pressed...... $pressed");
    Category category = categories[int.parse(pressed) - 1];
    int corret_level = 0;
    int correntScore = 0;
    var p_Id;
    int complite_level = 1;
    String co;
    complite_level = compliteLevel;
    corret_level = int.parse(categories[int.parse(pressed)].level);
    correntScore = currentScore;
    p_Id = pId;

    if (complite_level + 1 > corret_level) {
      return GestureDetector(
        onTap: () {
          _categoryPressed(
              category: category,
              context: context,
              complite_level: complite_level,
              corret_level: int.parse(pressed),
              correntScore: correntScore,
              pId: pId);
          print(pressed);
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Center(
            child: Text(
              pressed,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    } else if (complite_level + 1 == corret_level) {
      return GestureDetector(
        onTap: () {
          _categoryPressed(
              category: category,
              context: context,
              complite_level: complite_level,
              corret_level: int.parse(pressed),
              correntScore: correntScore,
              pId: pId);
          print(pressed);
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
          child: Center(
            child: Text(
              pressed,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          print(pressed);
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          child: Center(child: Icon(Icons.lock)),
        ),
      );
    }
  }
}

class _TimelineStepsChild extends StatelessWidget {
  const _TimelineStepsChild({
    Key key,
    this.title,
    this.subtitle,
    this.isLeftAlign,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign
          ? const EdgeInsets.only(right: 32, top: 16, bottom: 16, left: 10)
          : const EdgeInsets.only(left: 32, top: 16, bottom: 16, right: 10),
      child: Column(
        crossAxisAlignment:
            isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(child: const SizedBox(height: 20)),
          Text(
            subtitle,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
