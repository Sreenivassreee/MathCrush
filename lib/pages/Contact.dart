import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
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
                'Contact Us',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "arial",
                ),
              ),
            ),
          ];
        },
        body: Scaffold(
          body: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Are you facing any problem with your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Contact Us throw Whats App",
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
                          FlutterOpenWhatsapp.sendSingleMessage(
                            "919398195115",
                            "FromMathCrush",
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
        ),
      ),
    );
  }
}
