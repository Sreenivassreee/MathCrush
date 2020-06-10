import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
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
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: Theme.of(context).dividerColor,
                automaticallyImplyTitle: true,
                automaticallyImplyLeading: true,
                actionsForegroundColor: Theme.of(context).primaryColor,
                heroTag: "Hero",
                largeTitle: Text(
                  'Levels',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "arial",
                  ),
                ),
              ),
            ];
          },
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
                  : CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            // child: Text(
                            //   "Math Quiz",
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 16.0),
                            // ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 1.2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 15.0,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              _buildCategoryItem,
                              childCount: categories.length,
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
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
//    print("....................... $correntScore");
//    print("....................... $complite_level");

    if (complite_level > corret_level) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MaterialButton(
          elevation: 1.0,
          highlightElevation: 1.0,
          onPressed: () => _categoryPressed(context, category, complite_level,
              corret_level, correntScore, p_Id),
          shape: new CircleBorder(),
          color: Colors.red,
          textColor: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                category.level,
                minFontSize: 18.0,
                textAlign: TextAlign.center,
                maxLines: 1,
                wrapWords: false,
              ),
            ],
          ),
        ),
      );
    } else if (complite_level == corret_level) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MaterialButton(
          elevation: 1.0,
          highlightElevation: 1.0,
          onPressed: () => _categoryPressed(context, category, complite_level,
              corret_level, correntScore, p_Id),
          shape: new CircleBorder(),
          color: Colors.green,
          textColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                category.level,
                minFontSize: 18.0,
                textAlign: TextAlign.center,
                maxLines: 1,
                wrapWords: true,
              ),
            ],
          ),
        ),
      );
    } else {
      return MaterialButton(
        elevation: 1.0,
        highlightElevation: 1.0,
        onPressed: () {
          if (corret_level > complite_level) {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => LevelErrorPage(
            //       message: "Your Current Level is : $complite_level",
            //     ),
            //   ),
            // );
          } else {
            _categoryPressed(context, category, complite_level, corret_level,
                correntScore, p_Id);
            print("hi");
          }
        },
        shape: new CircleBorder(),
        color: Colors.blueGrey[800],
        textColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Icon(
                Icons.lock,
                color: Colors.white,
              ),
            )

            // AutoSizeText(
            //   category.level,
            //   minFontSize: 20.0,
            //   textAlign: TextAlign.center,
            //   maxLines: 3,
            //   wrapWords: false,
            // ),
          ],
        ),
      );
    }
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
        if (corret_level < complite_level) {
          // print(">>>>> $corret_level");
          // print(">>>>> $correntScore");

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
              p_Id: p_Id,
            ),
          );
        }
      },
      onClosing: () {},
    ),
  );
}
