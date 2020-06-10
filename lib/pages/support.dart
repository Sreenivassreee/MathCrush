import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    openWhatsApp(url) async {
      var whatsAppUrl = url;

      await canLaunch(whatsAppUrl)
          ? launch(whatsAppUrl)
          : Scaffold.of(context).showSnackBar(
              SnackBar(
                content: new Text("Failed"),
              ),
            );
    }

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: Theme.of(context).dividerColor,
              automaticallyImplyTitle: true,
              automaticallyImplyLeading: true,
              actionsForegroundColor: Theme.of(context).primaryColor,
              heroTag: "Hero",
              largeTitle: Text(
                'Support',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "arial",
                ),
              ),
            ),
          ];
        },
        body: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Are you facing any problem",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Join with us in testing group",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Center(
                            child: Container(
                              height: 60,
                              width: 60,
                              child: GestureDetector(
                                onTap: () {
                                  openWhatsApp(
                                    "https://chat.whatsapp.com/F0AAEDqDsQRHB6IdoQFxeP",
                                  );
                                },
                                child: Image.asset(
                                  "assets/images/whatsapp.png",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Do you want to Improve Application",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Text(
                            "Join with us in development group",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Container(
                              height: 60,
                              width: 60,
                              child: GestureDetector(
                                onTap: () {
                                  openWhatsApp(
                                    "https://chat.whatsapp.com/DbX6PBfn30d6gvwUPD4xMy",
                                  );
                                },
                                child: Image.asset(
                                  "assets/images/whatsapp.png",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                        ],
                      ),
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
