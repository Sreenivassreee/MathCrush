import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:mathcrush/pages/Contact.dart';
import 'package:mathcrush/pages/Profile.dart';
import 'package:mathcrush/pages/support.dart';
import 'package:mathcrush/resources/Global.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:theme_provider/theme_provider.dart';

class settings extends StatefulWidget {
  Map MainData;
  settings(this.MainData);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  void initState() {
    // data();
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );

  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade400,
  );

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                automaticallyImplyTitle: true,
                automaticallyImplyLeading: true,
                actionsForegroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).dividerColor,
                heroTag: "Hero0",
                largeTitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "arial",
                    ),
                  ),
                ),
              )
            ];
          },
          body: Scaffold(
            body: DefaultTextStyle(
              style: TextStyle(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ThemeConsumer(
                              child: Profile(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: Theme.of(context).dividerColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      widget.MainData["MainPhotoUrl"] == null
                                          ? "https://www.pngitem.com/pimgs/m/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png"
                                          : widget.MainData["MainPhotoUrl"],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  widget.MainData["MainName"],
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     MainData["About"],
                    //     style: TextStyle(
                    //       color: Colors.grey.shade400,
                    //     ),
                    //   ),
                    // ),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).dividerColor,
                      child: ListTile(
                        title: Text(
                          "Support Us",
                        ),
                        focusColor: Colors.red,
                        // subtitle: Text(
                        //   "English US",
                        //   style: greyTExt,
                        // ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ThemeConsumer(
                                child: support(),
                              ),
                            ),
                          );
                          // ThemeProvider.controllerOf(context).setTheme(pureblack);

                          // changeBrightness(context);
                        },
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).dividerColor,
                      child: ListTile(
                        title: Text(
                          "Contact Us",
                        ),
                        focusColor: Colors.red,
                        // subtitle: Text(
                        //   "English US",
                        //   style: greyTExt,
                        // ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ThemeConsumer(
                                child: Contact(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Card(
                      elevation: 0,
                      color: Theme.of(context).dividerColor,
                      child: ListTile(
                        title: Text(
                          "Privacy Policy",
                        ),
                        // subtitle: Text(
                        //   "Jane Doe",
                        //   style: greyTExt,
                        // ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          _launchURL(
                              "https://stevebrainsmathcrush.blogspot.com/p/privacy-policy.html");
                          // ThemeProvider.controllerOf(context).nextTheme();
                        },
                      ),
                    ),

                    Card(
                      elevation: 0,
                      color: Theme.of(context).dividerColor,
                      child: ListTile(
                        title: Text(
                          "Terms of Service",
                        ),
                        // subtitle: Text(
                        //   "Jane Doe",
                        //   style: greyTExt,
                        // ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          _launchURL(
                              "https://stevebrainsmathcrush.blogspot.com/p/terms-of-service.html");
                          // ThemeProvider.controllerOf(context).nextTheme();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).dividerColor,
                      child: ListTile(
                        title: Text(
                          "Change Theme   ( Dark / Light )",
                        ),
                        focusColor: Colors.red,
                        // subtitle: Text(
                        //   "English US",
                        //   style: greyTExt,
                        // ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          ThemeProvider.controllerOf(context).nextTheme();
                        },
                      ),
                    ),
                    // Card(
                    //   elevation: 0,
                    //   color: Theme.of(context).dividerColor,
                    //   child: ListTile(
                    //     title: Text(
                    //       "White Theme",
                    //     ),
                    //     focusColor: Colors.red,
                    //     // subtitle: Text(
                    //     //   "English US",
                    //     //   style: greyTExt,
                    //     // ),
                    //     trailing: Icon(
                    //       Icons.keyboard_arrow_right,
                    //       color: Colors.grey.shade400,
                    //     ),
                    //     onTap: () {
                    //       ThemeProvider.controllerOf(context).setTheme("white");

                    //       // ThemeProvider.controllerOf(context).setTheme(pureblack);

                    //       // changeBrightness(context);
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    // SwitchListTile(
                    //   title: Text("Email Notifications"),
                    //   subtitle: Text(
                    //     "On",
                    //     style: greyTExt,
                    //   ),
                    //   value: true,
                    //   onChanged: (val) {},
                    // ),
                    // SwitchListTile(
                    //   title: Text("Push Notifications"),
                    //   subtitle: Text(
                    //     "Off",
                    //     style: greyTExt,
                    //   ),
                    //   value: false,
                    //   onChanged: (val) {},
                    // ),
                    Card(
                      color: Theme.of(context).dividerColor,
                      elevation: 0,
                      child: ListTile(
                        title: Text("Logout"),
                        onTap: () async {
                          await logOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
