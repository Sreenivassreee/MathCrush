import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathcrush/Services/Firebase.dart';
import 'package:mathcrush/Services/Preferences.dart';
import 'package:mathcrush/models/PrefData.dart';

class Profile extends StatefulWidget {
  // Map ProfileData;
  // Profile({this.ProfileData});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<Profile>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController quali = TextEditingController();
  TextEditingController about = TextEditingController();

  // Map ProfileData;
  // MapScreenState(this.ProfileData);
  // String NameFiled, EmailHint, MobialHint, PinHint, StateHint;
  String photoUrl;

  final FocusNode myFocusNode = FocusNode();
  bool _status = true;
  bool _isUpdating = false;
  bool _isAbout = false;
  bool _isAboutSaveing = false;
  final _s = GlobalKey<ScaffoldState>();

  prefMainModel mainProfile = prefMainModel();

  @override
  void initState() {
    Pref.getMainPref();

    // print(mainProfile.MainName);

    // photoUrl =
    //     "https://img.favpng.com/5/21/12/person-logo-png-favpng-3kSpbaaQSfFQY7ZbahgiByCFp.jpg";
    // if (ProfileData != null) {
    //   setState(() {
    //     name.text = ProfileData['MainName'];
    //     email.text = ProfileData['MainEmail'];
    //     mobile.text = ProfileData['MainMobile'];
    //     photoUrl = ProfileData['MainPhotoUrl'];
    //     pin.text = ProfileData['MainPin'];
    //     state.text = ProfileData['MainState'];
    //     quali.text = ProfileData['Quali'];
    //   });
    // }

    Pref.getMainPref().then((value) {
      mainProfile = value;
      setState(() {
        email.text = mainProfile.MainEmail;
        photoUrl = mainProfile.MainPhotoUrl;
        name.text = mainProfile.MainName;
        mobile.text = mainProfile.MainMobile;
        pin.text = mainProfile.MainPin;
        state.text = mainProfile.MainState;
        quali.text = mainProfile.quali;
        about.text = mainProfile.about;
        var id = mainProfile.MainPId;
        print("id is ${mainProfile.MainEmail}");
      });
    });

    super.initState();
  }

  // void _snake({String message = "hi"}) {
  //   final snackBar = SnackBar(
  //       duration: Duration(seconds: 5),
  //       content: Text(
  //         message,
  //         style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //       ));
  //   _sca.currentState.showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _s,
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
          "Your Profile",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "arial",
          ),
        ),
      ),

      //   CupertinoPageScaffold(
      // child: NestedScrollView(
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return <Widget>[
      //       CupertinoSliverNavigationBar(
      //         heroTag: "Hero",
      //         actionsForegroundColor: Theme.of(context).primaryColor,
      //         backgroundColor: Theme.of(context).dividerColor,
      //         automaticallyImplyTitle: true,
      //         automaticallyImplyLeading: true,
      //         largeTitle: Text(
      //           'Your Profile',
      //           style: TextStyle(
      //             color: Theme.of(context).primaryColor,
      //             fontFamily: "arial",
      //           ),
      //         ),
      //       ),
      //     ];
      //   },

      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              photoUrl != null ? photoUrl : "shorturl.at/ruIU6",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, top: 16.0, right: 10),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: new TextFormField(
                                        maxLines: 5,
                                        controller: about,
                                        keyboardType: TextInputType.multiline,
                                        autofocus: _isAbout,
                                        decoration: new InputDecoration(
                                          labelText: "About",
                                          enabled: _isAbout,
                                          hintText:
                                              "Write Something About you we will show it in LeaderBoard",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                            borderSide: new BorderSide(),
                                          ),
                                          //fillColor: Colors.green
                                        ),
                                        validator: (val) {
                                          if (val.length == 0) {
                                            return "Email cannot be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),

                                      //   new TextField(
                                      //     controller: about,
                                      //     keyboardType: TextInputType.multiline,
                                      //     maxLines: 5,
                                      //     autofocus: _isAbout,
                                      //     decoration:

                                      //     InputDecoration(
                                      //       hintText:
                                      //           "Write About you Something we will show it in LeaderBoard",
                                      //       enabled: _isAbout,
                                      //     ),
                                      //   ),
                                    ),
                                    if (_isAbout == false)
                                      if (_isAboutSaveing == false)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.yellow,
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _isAbout = true;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      else
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: CupertinoActivityIndicator(),
                                          ),
                                        )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.yellow,
                                          child: IconButton(
                                            icon: Icon(Icons.save),
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _isAbout = false;
                                                  _isAboutSaveing = true;
                                                  sAbout();
                                                  print(about.text);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: new Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // CircleAvatar(
                                        //   radius: 70,
                                        //   backgroundImage: photoUrl != null
                                        //       ? NetworkImage(photoUrl)
                                        //       : Icon(Icons.person),
                                        // ),
                                      ],
                                    ),
//                        Padding(
//                          padding: EdgeInsets.only(top: 90.0, right: 100.0),
//                          child: new Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              new CircleAvatar(
//                                backgroundColor: Colors.grey,
//                                radius: 25.0,
//                                child: new Icon(
//                                  Icons.camera_alt,
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'About You',
                                            style: TextStyle(
                                                fontSize: 28.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon(Colors.green)
                                              : _getEditIcon(Colors.red)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            "Name",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: name,
                                            decoration: InputDecoration(
                                              hintText: name.text,
                                              enabled: !_status,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ID',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: email,
                                          decoration: InputDecoration(
                                            hintText: email.text,
                                            enabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: mobile,
                                          decoration: InputDecoration(
                                            hintText: mobile.text,
                                            enabled: !_status,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'State',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: state,
                                          decoration: InputDecoration(
                                            hintText: state.text,
                                            enabled: !_status,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Pin Code',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: pin,
                                          decoration: InputDecoration(
                                            hintText: pin.text,
                                            enabled: !_status,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Qualification / Studying',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller: quali,
                                          decoration: InputDecoration(
                                            hintText: quali.text,
                                            enabled: !_status,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_status == false)
                                  if (_isUpdating == false)
                                    _getActionButtons()
                                  else
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Center(
                                        child: Container(
                                          child: CupertinoActivityIndicator(
                                            radius: 15.0,
                                          ),
                                        ),
                                      ),
                                    )
                                else
                                  Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 16.0),
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          height: 50.0,
          width: double.infinity,
          child: new RaisedButton(
            child: new Text("Update"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Updated'),
              );
              _s.currentState.showSnackBar(snackBar);
              // Scaffold.of(context).showSnackBar(snackBar);
              // final snackBar = SnackBar(
              //     content: Text(
              //   "message",
              //   style: TextStyle(color: Colors.red),
              // ));

              // print(name.text);
              // print(email.text);
              // print(mobile.text);

              // print(pin.text);
              // print(state.text);
              // print(quali.text);
              // print(ProfileData['Mainid']);
              setState(() {
                // _status = true;
                _isUpdating = true;
              });
              Fire.updateProfile(
                userId: mainProfile.MainPId,
                name: name.text,
                mobile: mobile.text,
                state: state.text,
                quali: quali.text,
                pin: pin.text,
              ).then((value) {
                if (value == "Sucess") {
                  Pref.updateProfilePref(
                    name: name.text,
                    mobile: mobile.text,
                    state: state.text,
                    quali: quali.text,
                    pin: pin.text,
                  ).then((_value2) {
                    if (_value2 == "Sucess") {
                      print("Updated");
                      final snackBar = SnackBar(
                        content: Text('Updated'),
                      );
                      _s.currentState.showSnackBar(snackBar);

                      setState(() {
                        _status = true;
                        _isUpdating = false;
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: Text('Something went Wrong.. Try Again'),
                      );

                      _s.currentState.showSnackBar(snackBar);

                      // _snake(
                      //     message:
                      //         "Something went Wrong..Please Try Again later");
                      setState(() {
                        _status = true;
                        _isUpdating = false;
                      });
                    }
                  });
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'Something went Wrong.. Try Again',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );

                  _s.currentState.showSnackBar(snackBar);

                  // _snake(
                  //     message: "Something went Wrong..Please Try Again later");
                  setState(() {
                    _status = true;
                    _isUpdating = false;
                  });
                }
              });

              // Pref.getMainPref().then((value) {
              //   mainProfile = value;

              //   setState(() {
              //     name.text = mainProfile.MainName;
              //     mobile.text = mainProfile.MainMobile;
              //     pin.text = mainProfile.MainPin;
              //     state.text = mainProfile.MainState;
              //     quali.text = mainProfile.quali;
              //   });
              // });
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(
                10.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEditIcon(Color color) {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: color,
        radius: 18.0,
        child: new Icon(
          Icons.mode_edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = !_status;
        });
        // print(_status);
      },
    );
  }

  void sAbout() {
    _isAboutSaveing = true;
    print("id is ${mainProfile.MainPId}");
    Fire.saveAbout(userId: mainProfile.MainPId, about: about.text).then(
      (value) {
        print("id is ${mainProfile.MainPId}");

        if (value == "Sucess") {
          Pref.saveAboutPref(about: about.text).then(
            (_value2) {
              if (_value2 == "Sucess") {
                if (this.mounted) {
                  setState(
                    () {
                      _isAboutSaveing = false;
                      // _snake(message: "Updated");
                    },
                  );
                  final snackBar = SnackBar(
                    content: Text('Updated'),
                  );

                  _s.currentState.showSnackBar(snackBar);
                }
              } else {
                final snackBar = SnackBar(
                  content: Text('Something went Wrong.. Try Again'),
                );

                _s.currentState.showSnackBar(snackBar);

                // _snake(message: "Something went Wrong..Please Try Again later");
                setState(() {
                  _isAbout = false;
                  _isAboutSaveing = false;
                });
              }
            },
          );
        } else {
          final snackBar = SnackBar(
            content: Text('Something went Wrong.. Try Again'),
          );

          _s.currentState.showSnackBar(snackBar);

          // _snake(message: "Something went Wrong..Please Try Again later");
          setState(() {
            _isAbout = false;
            _isAboutSaveing = false;
          });
        }
      },
    );
  }
}
