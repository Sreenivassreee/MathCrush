import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:theme_provider/theme_provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../models/category.dart';
import './quiz_options.dart';

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
  final _con = ScrollController();
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

    return
        // CupertinoPageScaffold(
        //   child: NestedScrollView(
        //     physics: ScrollPhysics(),
        //     controller: _con,
        //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //       return <Widget>[
        //         CupertinoSliverNavigationBar(
        //           automaticallyImplyTitle: false,
        //           heroTag: "Hero",
        //           previousPageTitle: "Home",
        //           automaticallyImplyLeading: true,
        //           backgroundColor: Theme.of(context).dividerColor,
        //           largeTitle: Text(
        //             'Levels',
        //             style: TextStyle(
        //               fontFamily: "arial",
        //               color: Theme.of(context).primaryColor,
        //             ),
        //           ),
        //         )
        //       ];
        //     },
        Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Levels",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "arial",
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Lis(
                    pId: pId,
                    compliteLevel: compliteLevel,
                    currentScore: currentScore)
          ],
        ),
      ),
    );
  }
}

class Lis extends StatefulWidget {
  var pId;
  var currentScore, compliteLevel;

  Lis({this.pId, this.compliteLevel, this.currentScore});

  @override
  _LisState createState() => _LisState();
}

class _LisState extends State<Lis> {
  final _controller = ScrollController();

  final _height = 100.0;

  int corret_level = 0;

  int correntScore = 0;

  var p_Id;

  int complite_level = 1;

  String co;
  @override
  void initState() {
    complite_level = widget.compliteLevel;

    // corret_level = int.parse(categories[int.parse(pressed)].level);

    correntScore = widget.currentScore;

    p_Id = widget.pId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.compliteLevel);
    print("widget.currentScore${widget.currentScore}");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: () => _animateToIndex(widget.compliteLevel - 3),
        child: Icon(
          Icons.location_on,
          size: 45,
          color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        physics: ScrollPhysics(),
        controller: _controller,
        itemCount: categories.length,
        itemBuilder: (_, i) => Container(
            height: _height,
            child: widget.compliteLevel > categories[i].id
                ? t(
                    i: i,
                    color: Colors.red,
                    category: categories[i],
                    context: context,
                    pressed: categories[i].level,
                    complite_level: widget.compliteLevel,
                    correntScore: widget.currentScore,
                    pId: p_Id,
                  )
                : widget.compliteLevel == categories[i].id
                    ? t(
                        i: i,
                        color: Colors.green,
                        category: categories[i],
                        context: context,
                        pressed: categories[i].level,
                        complite_level: widget.compliteLevel,
                        correntScore: widget.currentScore,
                        pId: p_Id,
                      )
                    : t(i: i, color: Colors.grey, islock: true, action: false)

            // TimelineTile(
            //   alignment: TimelineAlign.left,

            //   rightChild: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       child: Text(categories[i].level),
            //     ),
            //   ),
            // ),
            ),
      ),
    );
  }

  _animateToIndex(i) => _controller.animateTo(
        _height * i,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
}

// class tile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

t(
    {int i,
    color,
    islock,
    pressed,
    category,
    context,
    action,
    complite_level,
    correntScore,
    pId}) {
  final isFirst = i == 0;
  final isLast = i == categories.length - 1;
  double indicatorY;
  if (isFirst) {
    indicatorY = 0.2;
  } else if (isLast) {
    indicatorY = 0.8;
  } else {
    indicatorY = 0.5;
  }
  print("correntScore $correntScore");
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineX: 0.1,
    isFirst: isFirst,
    isLast: isLast,
    indicatorStyle: IndicatorStyle(
      width: 50,
      height: 50,
      indicatorY: indicatorY,
      indicator: GestureDetector(
        onTap: () {
          action == false
              ? {}
              : _categoryPressed(
                  category: category,
                  context: context,
                  complite_level: complite_level,
                  corret_level: int.parse(pressed),
                  correntScore: correntScore,
                  pId: pId,
                );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: islock == true
                ? Icon(Icons.lock)
                : Text(
                    categories[i].level,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    ),
    rightChild: Card(
      shape: BeveledRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      elevation: 0.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                categories[i].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            // Text(
            //   categories[i].message,
            //   style: TextStyle(
            //     fontSize: 15.0,
            //   ),
            // ),
          ],
        ),
      ),
    ),
    topLineStyle: const LineStyle(
      color: Color(0xFFCB8421),
      width: 3,
    ),
  );
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
