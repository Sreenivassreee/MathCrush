import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'dart:ui';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class picture extends StatefulWidget {
  String picUrl;
  picture({this.picUrl});

  @override
  _pictureState createState() => _pictureState();
}

class _pictureState extends State<picture> {
  bool isDownload;
  int persentage;
  @override
  void initState() {
    super.initState();
    setState(() {
      isDownload = false;
      persentage = 0;
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
                'Pictorial',
                style: TextStyle(
                  fontFamily: "arial",
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ];
        },
        body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _save();
              setState(() {
                isDownload = true;
              });
            },
            child: Icon(Icons.arrow_downward),
          ),
          body: Center(
            child: Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.picUrl,
                    ),
                  ),
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
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        center: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
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
