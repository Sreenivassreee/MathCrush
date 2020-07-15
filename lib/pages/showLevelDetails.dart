import 'package:flutter/material.dart';
import 'package:mathcrush/pages/intro.dart';

class showLevelDetails {
  BuildContext context;

  String message, level, detail, ex;

  showLevelDetails(
      {this.message, this.context, this.level, this.detail, this.ex}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding:
              // const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 0),
              const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  "Level : $level",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  message ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  "Explanation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Flexible(
                child: Text(
                  detail ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  "Example",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Flexible(
                child: Text(
                  ex ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      9.0,
                    ),
                  ),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //     builder: (contaxt) => Intro(),
                  //   ),
                  //   (route) => false,
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
