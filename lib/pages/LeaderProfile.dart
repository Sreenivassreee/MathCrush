import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class LeaderProfile extends StatefulWidget {
  var profile;
  LeaderProfile(this.profile);

  @override
  _LeaderProfileState createState() => _LeaderProfileState();
}

class _LeaderProfileState extends State<LeaderProfile> {
  @override
  Widget build(BuildContext context) {
    print(widget.profile['currentScore']);
    return ThemeProvider(
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                heroTag: "Hero2",
                automaticallyImplyTitle: true,
                automaticallyImplyLeading: true,
                actionsForegroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).dividerColor,
                largeTitle: Text(
                  'Profile',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "arial",
                  ),
                ),
              ),
            ];
          },
          body: ThemeProvider(
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Hero(
                          tag: widget.profile['photoUrl'],
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  widget.profile['photoUrl'] != null
                                      ? (widget.profile['photoUrl'])
                                      : Icon(Icons.person),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Text(
                            widget.profile['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "arial",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: widget.profile['about'] != null
                              ? Text(
                                  widget.profile['about'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "arial",
                                  ),
                                )
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 12, right: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 120,
                                  child: Card(
                                    color: Theme.of(context).cardColor,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    elevation: 0.0,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "${widget.profile['currentLevel'] - 1}",
                                            style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 35.0,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            'Levels Completed',
                                            style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 18.0,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 120,
                                  child: Card(
                                    color: Theme.of(context).cardColor,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    elevation: 0.0,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "${widget.profile['currentScore']}",
                                            style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 30.0,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text(
                                            'Coins',
                                            style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 20.0,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
