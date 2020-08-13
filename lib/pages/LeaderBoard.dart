import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathcrush/models/leaderProfile.dart';
import 'package:mathcrush/pages/LeaderProfile.dart';
import 'package:theme_provider/theme_provider.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool _isLoading = true;
  List<leaderProfile> profile = List();
  @override
  void initState() {
    // data();
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([]);
    //1
  }

  // void data() {
  //   SQLServices.profilePersonData().then((value) {
  //     print(value.length);
  //     if (value.length != 0) {
  //       if (this.mounted) {
  //         setState(() {
  //           _isLoading = false;
  //           profile = value;
  //         });
  //       }
  //     } else {
  //       print("hi");
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _query = Firestore.instance
        .collection('Users')
        .orderBy('currentScore', descending: true)
        .limit(5)
        .snapshots();
    return ThemeProvider(
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: Theme.of(context).dividerColor,
                automaticallyImplyTitle: true,
                automaticallyImplyLeading: true,
                actionsForegroundColor: Theme.of(context).dividerColor,
                // heroTag: "Hero2",
                largeTitle: Text(
                  'LeaderBoard',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "arial",
                  ),
                ),
              ),
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return CupertinoActivityIndicator();
                } else {
                  // print("Lenght is ${snapshot.data.documents.length}");

                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext contxt, int i) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThemeConsumer(
                                    child: LeaderProfile(
                                      snapshot.data.documents[i],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Card(
                                elevation: 0.0,
                                color: Theme.of(context).dividerColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    top: 10.0,
                                    bottom: 10.0,
                                    right: 10.0,
                                  ),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        // Hero(
                                        // tag: snapshot.data.documents[i]
                                        // ['photoUrl'],
                                        // child:
                                        Hero(
                                          tag: snapshot.data.documents[i]
                                              ['photoUrl'],
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  snapshot.data.documents[i]
                                                              ['photoUrl'] !=
                                                          null
                                                      ? (snapshot
                                                              .data.documents[i]
                                                          ['photoUrl'])
                                                      : Icon(Icons.person),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          // CircleAvatar(
                                          //   radius: 40.0,
                                          //   backgroundImage: CachedNetworkImageProvider(
                                          //     snapshot.data.documents[i]
                                          //         ['photoUrl'],
                                          //   ),
                                          // ),
                                        ),
                                        // ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 22.0,
                                            ),
                                            child: Container(
                                              height: 70,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data.documents[i]
                                                        ['name'],
                                                    style: TextStyle(
                                                        // fontSize: 16.0,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.0,
                                                  ),
                                                  Flexible(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Coins",
                                                          style: TextStyle(
                                                            // fontSize: 16.0,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                        Text(
                                                          "L C",
                                                          style: TextStyle(
                                                            // fontSize: 16.0,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data
                                                              .documents[i][
                                                                  'currentScore']
                                                              .toString(),
                                                          style: TextStyle(
                                                              // fontSize: 15.0,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                        Text(
                                                          "${snapshot.data.documents[i]['currentLevel'] - 1}",
                                                          style: TextStyle(
                                                              // fontSize: 15.0,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 25.0),
                          //   child:

                          // )
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
