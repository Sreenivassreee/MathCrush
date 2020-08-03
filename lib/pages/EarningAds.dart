import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mathcrush/models/FeedModel.dart';

import 'package:theme_provider/theme_provider.dart';

class EarnAds extends StatefulWidget {
  @override
  _EarnAdsState createState() => _EarnAdsState();
}

class _EarnAdsState extends State<EarnAds> {
  PageController controller = PageController();
  List<FeedModel> feed = List();
  bool _isLoading = true;
  var scr = new GlobalKey();

  var currentPageValue = 0.0;
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
    //1
  }

  // takescrshot() async {
  //   RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
  //   var image = await boundary.toImage();
  //   var byteData = await image.toByteData(format: ImageByteFormat.png);
  //   var pngBytes = byteData.buffer.asUint8List();
  //   print(pngBytes);
  // }

//  takeScreenShot() async{
//     RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
//     ui.Image image = await boundary.toImage();
//     final directory = (await getApplicationDocumentsDirectory()).path;
//     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData.buffer.asUint8List();
//     print(pngBytes);
//     File imgFile =new File('$directory/screenshot.png');
//     imgFile.writeAsBytes(pngBytes);
//   }
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Scaffold(
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('EarnAds')
              .orderBy('pri', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              return ThemeProvider(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemBuilder: (context, i) {
                    var url = snapshot.data.documents[i]['Poster url'];
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height,
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(seconds: 1),
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              imageUrl: url,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                            // child: CachedNetworkImage(
                            //   imageUrl: snapshot.data.documents[i]
                            //       ['Poster url'],
                            //   errorWidget: (context, url, error) =>
                            //       Image.network(
                            //     "",
                            //     //TODO:
                            //     fit: BoxFit.cover,
                            //   ),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          Container(
                            color: Colors.black26,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0,
                                        ),
                                        child: Text(
                                          "Start Date : ${snapshot.data.documents[i]['sDate']}" ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0,
                                        ),
                                        child: Text(
                                          "End Date : ${snapshot.data.documents[i]['sDate']}" ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
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
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                ),
              );
            }
          },
        )

            // height: MediaQuery.of(context).size.height,
            // child: Image.network(
            //   "https://images.pexels.com/photos/3183183/pexels-photo-3183183.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
            //   fit: BoxFit.cover,
            // ),
            ),
      ),
    );
  }
}
