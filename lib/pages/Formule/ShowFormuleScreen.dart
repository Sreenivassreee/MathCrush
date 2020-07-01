import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/Services/admob.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class ShowFormuleScreen extends StatefulWidget {
  var data;
  ShowFormuleScreen(this.data);

  @override
  _ShowFormuleScreenState createState() => _ShowFormuleScreenState();
}

class _ShowFormuleScreenState extends State<ShowFormuleScreen> {
  final BaseCacheManager baseCacheManager = DefaultCacheManager();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String testDevice = 'A293937208D4A2DC978165873AF0EB61';

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Math', 'Education', 'mathematics', 'love'],
  );
  InterstitialAd _interstitialAd;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  String url, topic;
  // bool btn;
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
          if (event == MobileAdEvent.failedToLoad) {
            _interstitialAd.load();
          } else if (event == MobileAdEvent.loaded) {
            print('interstitialAd show');
            _interstitialAd.show();
          }
        });
  }

  @override
  void dispose() {
    // createInterstitialAd().dispose();

    super.dispose();
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: APPID);

    // btn = true;

    url = widget.data["url"];
    topic = widget.data["topic"];

    // createInterstitialAd()..load();

    videoAd.load(
      adUnitId: RewardedVideoAd.testAdUnitId,
      targetingInfo: targetingInfo,
    );

    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        // setState(() {
        //   // _coins += rewardAmount;
        // });
      } else if (event == RewardedVideoAdEvent.started) {
        // btn = true;
      } else if (event == RewardedVideoAdEvent.completed) {
        videoAd.load(
          adUnitId: RewardedVideoAd.testAdUnitId,
          targetingInfo: targetingInfo,
        );
        Share();
      } else if (event == RewardedVideoAdEvent.loaded) {
        setState(() {
          // btn = true;
        });
        // print(">>>>>>>>>>>>>> flase");
        // Share();
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        videoAd.load(
          adUnitId: RewardedVideoAd.testAdUnitId,
          targetingInfo: targetingInfo,
        );
        Share();
      } else if (event == RewardedVideoAdEvent.closed) {
        videoAd.load(
          adUnitId: RewardedVideoAd.testAdUnitId,
          targetingInfo: targetingInfo,
        );
        Share();
      }
      print("end");
    };
    super.initState();
  }

  // void abc() {
  //   try {} catch (e) {
  //     print(e);
  //   }
  // }

  void Share() {
    var appUrl =
        "https://play.google.com/store/apps/details?id=com.stevebrains.sreenivas.mathcrush";
    baseCacheManager.getFile(url).first.then((info) {
      info.file.readAsBytes().then((bytes) {
        WcFlutterShare.share(
            text:
                "Download App 💖 \n$appUrl \n\nDownload Sheet \n$url\n\nMade in India 🇮🇳",
            sharePopupTitle: 'Share from MathCrush',
            fileName: '$topic.png',
            mimeType: 'image/png',
            bytesOfFile: bytes);
        // snake();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.screen_share),
          onPressed: () {
            // createInterstitialAd()
            //   ..load()
            //   ..show()

            videoAd
              ..load(
                adUnitId: RewardedVideoAd.testAdUnitId,
                targetingInfo: targetingInfo,
              )
              ..show();
            setState(() {
              // btn = false;
            });
            // abc();
            // try {
            //   // Share();
            // } catch (e) {
            //   // ErrorPage(context: context);
            // }
          }),
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
          topic,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "arial",
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              fadeInDuration: Duration(seconds: 1),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: url,
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            //  Image.network(
            // data["url"],
            // fit: BoxFit.fitWidth,
            // ),
          ),
        ),
      ),
    );
  }
}
