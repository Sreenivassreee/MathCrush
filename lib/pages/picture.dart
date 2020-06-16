import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class picture extends StatelessWidget {
  String picUrl;
  picture({this.picUrl});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              automaticallyImplyTitle: true,
              heroTag: "Hero",
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).dividerColor,
              largeTitle: Text(
                'Pictorial',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: picUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
