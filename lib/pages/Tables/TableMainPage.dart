import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/pages/Tables/Tables.dart';
import 'package:theme_provider/theme_provider.dart';

class TableMainPage extends StatelessWidget {
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
                'Tables',
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
                    crossAxisCount: 5,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 15.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    _buildCategoryItem,
                    childCount: 100,
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
      highlightElevation: 1.0,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext) => ThemeConsumer(
              child: Tables(
                index + 1,
              ),
            ),
          ),
        );
      },
      shape: new CircleBorder(),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            (index + 1).toString(),
            minFontSize: 18.0,
            textAlign: TextAlign.center,
            maxLines: 1,
            wrapWords: false,
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
