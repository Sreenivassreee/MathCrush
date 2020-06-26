import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllTableDesign extends StatelessWidget {
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
                    childCount: 10,
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
      elevation: 1.0,
      // highlightElevation: 1.0,
      onPressed: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext) => ThemeConsumer(
        //       child: Tables(
        //         index + 1,
        //       ),
        //     ),
        //   ),
        // );
      },
      color: Theme.of(context).primaryColor,
      textColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              "Multiplication",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                "x",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
