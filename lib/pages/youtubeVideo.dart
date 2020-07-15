import 'dart:developer';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathcrush/Services/admob.dart';
import 'package:mathcrush/models/category.dart';
import 'package:mathcrush/pages/picture.dart';
import 'package:mathcrush/resources/api_provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtube extends StatefulWidget {
  Category cata;
  Youtube({this.cata});
  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool isLoadingLearn = true;
  String video;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Math', 'Education', 'mathematics', 'love'],
  );
  InterstitialAd _interstitialAd;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  String url, topic;
  int amount = 0;
  @override
  void initState() {
    videoAd
      ..load(
        adUnitId: revardedId,
        targetingInfo: targetingInfo,
      );
    adLeasion();
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    super.initState();
    print(widget.cata.level);
    // setState(() {
    //   video = learn.video;
    // });

    abc();
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: interId,
        //Change Interstitial AdUnitId with Admob ID
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

  adLeasion() {
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      amount = rewardAmount;
      print("REWARDED VIDEO AD $event");
      if (event == RewardedVideoAdEvent.rewarded) {
      } else if (event == RewardedVideoAdEvent.started) {
        _controller.pause();
      } else if (event == RewardedVideoAdEvent.completed) {
        videoAd.load(
          adUnitId: revardedId,
          targetingInfo: targetingInfo,
        );
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        videoAd.load(
          adUnitId: revardedId,
          targetingInfo: targetingInfo,
        );
      } else if (event == RewardedVideoAdEvent.closed) {
        // setState(() {
        //   show = false;
        // });
        _controller.play();

        videoAd.load(
          adUnitId: revardedId,
          targetingInfo: targetingInfo,
        );

        // dialog(context: context);
      }
    };
  }

  abc() async {
    await getL(widget.cata).then((f) {
      setState(() {
        video = learn.video;
        print("video $video");
      });

      print("video $video");
      _controller = YoutubePlayerController(
        initialVideoId: video,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _idController = TextEditingController();
      _seekToController = TextEditingController();
      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;
    });
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  getL(category) async {
    print(category);
    await getLearn(category).then((value) {
      if (value != null) {
        setState(() {
          learn = value;
          isLoadingLearn = false;
        });
        // return value;
      }
    });
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return isLoadingLearn
        ? Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                // Expanded(
                // child: Text(
                //   _controller.metadata.title,
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 18.0,
                //   ),
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 1,
                // ),
                // ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {
                        // _controller.pause();

                        videoAd
                          ..load(
                            adUnitId: revardedId,
                            targetingInfo: targetingInfo,
                          )
                          ..show();
                        // loading();
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {
                        createInterstitialAd()
                          ..load()
                          ..show();
                      },
                    ),
                  ],
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                // _controller
                // .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                // _showSnackBar('Next Video Started!');
              },
            ),
            builder: (context, player) => CupertinoPageScaffold(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    CupertinoSliverNavigationBar(
                      automaticallyImplyTitle: true,
                      heroTag: "Hero",
                      automaticallyImplyLeading: true,
                      backgroundColor: Theme.of(context).dividerColor,
                      largeTitle: Text(
                        'Tutorials',
                        style: TextStyle(
                          fontFamily: "arial",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ];
                },
                body: Scaffold(
                  body: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      player,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _space,
                            _text('Title', _videoMetaData.title),
                            _space,
                            _text('Channel', _videoMetaData.author),
                            _space,
                            // _text('Video Id', _videoMetaData.videoId),
                            // _space,

                            // _space,
                            // TextField(
                            //   enabled: _isPlayerReady,
                            //   controller: _idController,
                            //   decoration: InputDecoration(
                            //     border: InputBorder.none,
                            //     hintText: 'Enter youtube \<video id\> or \<link\>',
                            //     fillColor: Colors.blueAccent.withAlpha(20),
                            //     filled: true,
                            //     hintStyle: const TextStyle(
                            //       fontWeight: FontWeight.w300,
                            //       color: Colors.blueAccent,
                            //     ),
                            //     suffixIcon: IconButton(
                            //       icon: const Icon(Icons.clear),
                            //       onPressed: () => _idController.clear(),
                            //     ),
                            //   ),
                            // ),
                            // _space,
                            // Row(
                            //   children: [
                            //     _loadCueButton('LOAD'),
                            //     const SizedBox(width: 10.0),
                            //     _loadCueButton('CUE'),
                            //   ],
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  onPressed: _isPlayerReady
                                      ? () {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                          setState(() {});
                                        }
                                      : null,
                                ),
                                IconButton(
                                  icon: Icon(_muted
                                      ? Icons.volume_off
                                      : Icons.volume_up),
                                  onPressed: _isPlayerReady
                                      ? () {
                                          _muted
                                              ? _controller.unMute()
                                              : _controller.mute();
                                          setState(() {
                                            _muted = !_muted;
                                          });
                                        }
                                      : null,
                                ),
                                FullScreenButton(
                                  controller: _controller,
                                  color: Colors.blueAccent,
                                ),
                                // IconButton(
                                //   icon: const Icon(Icons.skip_next),
                                //   onPressed: _isPlayerReady
                                //       ? () => _controller.load(_ids[
                                //           (_ids.indexOf(_controller.metadata.videoId) +
                                //                   1) %
                                //               _ids.length])
                                //       : null,
                                // ),
                              ],
                            ),
                            // _space,
                            Row(
                              children: <Widget>[
                                const Text(
                                  "Volume",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                Expanded(
                                  child: Slider(
                                    inactiveColor: Colors.transparent,
                                    value: _volume,
                                    min: 0.0,
                                    max: 100.0,
                                    divisions: 10,
                                    label: '${(_volume).round()}',
                                    onChanged: _isPlayerReady
                                        ? (value) {
                                            setState(() {
                                              _volume = value;
                                            });
                                            _controller
                                                .setVolume(_volume.round());
                                          }
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            // _space,

                            // AnimatedContainer(
                            //   duration: const Duration(milliseconds: 800),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20.0),
                            //     color: _getStateColor(_playerState),
                            //   ),
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(
                            //     _playerState.toString(),
                            //     style: const TextStyle(
                            //       fontWeight: FontWeight.w300,
                            //       color: Colors.white,
                            //     ),
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.stickyNote,
                                    size: 50,
                                  ),
                                  onPressed: learn == null
                                      ? null
                                      : () {
                                          _controller.pause();

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (
                                                context,
                                              ) =>
                                                  ThemeConsumer(
                                                child: Picture(
                                                  picUrl: learn.pic,
                                                ),
                                              ),
                                            ),
                                          );
                                          // print("video there ${learn.pic}");
                                        },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Notes"),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title :  ',
        style: const TextStyle(
          color: Colors.red,
          fontFamily: "arial",
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: const TextStyle(
              fontFamily: "arial",
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 15);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                    _idController.text,
                  );
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
