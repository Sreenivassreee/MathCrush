import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mathcrush/Services/admob.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:ui';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class Picture extends StatefulWidget {
  String picUrl;
  Picture({this.picUrl});
  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  bool isDownload;
  int persentage = 0;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Math', 'Education', 'mathematics', 'love', 'cinema'],
  );
  InterstitialAd _interstitialAd;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  String url, topic;
  @override
  void initState() {
    super.initState();
    createInterstitialAd()..load();
    setState(() {
      isDownload = false;
      persentage = 0;
    });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: interId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
          if (event == MobileAdEvent.failedToLoad) {
            _interstitialAd.load();
          } else if (event == MobileAdEvent.loaded) {
            print('interstitialAd show');
            _interstitialAd.show();
          } else if (event == MobileAdEvent.closed) {}
        });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    // return CupertinoPageScaffold(
    //   child: NestedScrollView(
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return <Widget>[
    //       CupertinoSliverNavigationBar(
    //           automaticallyImplyTitle: true,
    //           heroTag: "Hero",
    //           automaticallyImplyLeading: true,
    //           backgroundColor: Theme.of(context).dividerColor,
    //           largeTitle: Text(
    //             'Pictorial',
    //             style: TextStyle(
    //               fontFamily: "arial",
    //               color: Theme.of(context).primaryColor,
    //             ),
    //           ),
    //         )
    //       ];
    //     },
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },

          // Icons.arrow_back_ios,
          // color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Notes",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createInterstitialAd()
            ..load()
            ..show();
          _save();
          setState(() {
            isDownload = true;
            persentage = 0;
          });
        },
        child: Icon(Icons.arrow_downward),
      ),
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Center(
                child: PhotoView(
                  imageProvider: NetworkImage(widget.picUrl),
                ),
              ),

              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: CachedNetworkImage(
              //       fadeInDuration: Duration(seconds: 1),
              //       placeholder: (context, url) => Center(
              //         child: CircularProgressIndicator(),
              //       ),
              //       imageUrl: widget.picUrl,
              //       errorWidget: (context, url, error) => Icon(Icons.error),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Center(
                child: isDownload == true
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        ),
                        height: 90,
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            persentage.toString() != null
                                ? CircularPercentIndicator(
                                    radius: 50.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    backgroundColor: Colors.white,
                                    animationDuration: 5000,
                                    percent: 1,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: new Text(
                                        persentage.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    progressColor: Colors.red,
                                  )
                                : null,
                            Text(
                              "Please Wait...",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(
      widget.picUrl,
      onReceiveProgress: (rec, total) {
        setState(() {
          persentage = ((rec / total) * 100).round();
        });
      },
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    print("responce $response");
    print(widget.picUrl);
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(
        response.data,
      ),
    );
    print(result);
    setState(() {
      isDownload = false;
    });
    loading(mess: "Download completed...\n Saved to Gallery");

    // Navigator.pop(context);
  }

  _askPermission() async {
    var status = await Permission.storage.status;

    print(status);

    if (status.isUndetermined) {
      requestPermission(Permission.storage);
    } else if (status.isDenied) {
      requestPermission(Permission.storage);
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
