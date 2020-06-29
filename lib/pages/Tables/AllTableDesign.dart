import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/pages/Tables/TableMainPage.dart';
import 'package:theme_provider/theme_provider.dart';

class AllTableDesign extends StatelessWidget {
  // final List operations = [
  //   ["Multiplication",["1"],
  //   "Division",
  //   "Addition",
  //   "Subtraction",
  //   "Square",
  //   "Square Root",
  //   "Square Cube",
  //   "Cube Root",
  //   "Factorial"]
  // ];
  final List operations = [
    ["Multiplication", "1 x 1 = 1", "1 x 2 = 2", "1 x 3 = 3"],
    ["Division", "1 / 1 = 1", "1 / 2 = 0", "1 / 3 = 0"],
    ["Addition", "1 + 1 = 2", "1 + 2 = 3", "1 + 3 = 4"],
    ["Subtraction", "1 - 1 = 0", "1 - 2 = -1", "1 - 3 = -2"],
    ["Power", "1^1 = 1", "1^2 = 1", "1^3 = 1"],
    ["Square Root", "v1 = 1.00", "v2 = 1.41", "v3 = 1.73"],
    ["Square Cube", "1^3 = 01", "2^3 = 08", "3^3 = 27"],
    ["Cube Root", "3v1 = 1.00", "3v2 = 1.26", "3v3 = 1.44"],
    ["Factorial", "1! = 1", "2! = 2", "3! = 3"]
  ];

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
                "Tables",
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context2).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Container(
          child: CustomScrollView(
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    _buildCategoryItem,
                    childCount: operations.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    return MaterialButton(
      elevation: 0.0,
      // highlightElevation: 1.0,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext) => ThemeConsumer(
              child: TableMainPage(operations[index][0]
                  // index + 1,
                  ),
            ),
          ),
        );
      },
      // color: Theme.of(context).primaryColor,
      color: Theme.of(context).cardColor,

      textColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              operations[index][0],
              style: TextStyle(
                color: Colors.red,
                fontSize: 21,
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: Container(
                  child: Text(
                    operations[index][1],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,

                      // color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  child: Text(
                    operations[index][2],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,

                      // color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  child: Text(
                    operations[index][3],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,

                      // color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
