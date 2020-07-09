import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/Services/Firebase.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/Services/admob.dart';
import 'package:mathcrush/resources/Global.dart';

class RewardScreen extends StatefulWidget {
  String id;
  int coins;
  RewardScreen({this.id, this.coins});
  @override
  _RewardScreenState createState() => _RewardScreenState(id, coins);
}

class _RewardScreenState extends State<RewardScreen> {
  // static const String testDevice = "k";
  //  'A293937208D4A2DC978165873AF0EB61';
  int coins;
  String id;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Math', 'Education', 'mathematics', 'love'],
  );
  InterstitialAd _interstitialAd;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  String url, topic;
  int amount = 0;

  _RewardScreenState(this.id, this.coins);
  @override
  void initState() {
    videoAd
      ..load(
        adUnitId: revardedId,
        targetingInfo: targetingInfo,
      );
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      amount = rewardAmount;
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          coins = coins + amount;
        });
        print("reward is $rewardType");
        print("rewardAmount is $rewardAmount");
        updateCoins(coins: coins);
      } else if (event == RewardedVideoAdEvent.started) {
        // btn = true;
      } else if (event == RewardedVideoAdEvent.completed) {
        videoAd.load(
          adUnitId: revardedId,
          targetingInfo: targetingInfo,
        );
      } else if (event == RewardedVideoAdEvent.loaded) {
        // print(">>>>>>>>>>>>>> flase");
        // Share();
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        videoAd.load(
          adUnitId: revardedId,
          targetingInfo: targetingInfo,
        );
      } else if (event == RewardedVideoAdEvent.closed) {
        // setState(() {
        //   show = false;
        // });
        videoAd.load(
          adUnitId: revardedId,
          targetingInfo: targetingInfo,
        );
        // dialog(context: context);
      }
      // ad();
      super.initState();
    };
  }

  updateCoins({coins}) {
    Fire.fireUpdaeScore(id, coins).then((value) {
      if (value == "Sucess") {
        Pref.saveOnlyScorePref(coins).then((value) {
          if (value == "Sucess") {
            print("Updated");
            dialog(
                addedCoins: amount.toString(),
                context: context,
                url: "https://media.giphy.com/media/MkvZFvzHIWbRK/giphy.gif");
          } else {
            dialog(
              addedCoins: "Error",
              context: context,
              url: "https://media.giphy.com/media/f9k1tV7HyORcngKF8v/giphy.gif",
            );
          }
        });
      } else {
        dialog(
          addedCoins: "Error",
          context: context,
          url: "https://media.giphy.com/media/f9k1tV7HyORcngKF8v/giphy.gif",
        );
      }
    });
  }

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
                'Rewards',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Scaffold(
          body: Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            child: Card(
                              elevation: 0.0,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              // elevation: 10.0,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 55,
                                      child: Image.asset(
                                        "assets/images/coins1.png",
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '$coins',
                                          style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 25.0,
                                            color: Color(
                                              0xffFF9C00,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Your Coins",
                                          style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
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
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Container(
                      child: Card(
                        elevation: 0.0,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "If you want to Earn more coins you need see videos,to watch the video just click on show video button,Each Video Give You 10 Coins",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ThemeConsumer(
                        //       child: WinnersPage(),
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        height: 115,
                        width: 115,
                        child: GestureDetector(
                          onTap: () {
                            videoAd
                              ..load(
                                adUnitId: revardedId,
                                targetingInfo: targetingInfo,
                              )
                              ..show();
                            loading();
                          },
                          child: Card(
                            elevation: 0.0,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Icon(
                                      CupertinoIcons.play_arrow_solid,
                                      size: 60,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "Show Video",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Flexible(
                  //   child: Container(
                  //     child: Image.network(
                  //         // "https://media.giphy.com/media/MkvZFvzHIWbRK/giphy.gif"),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
