import 'package:flutter/material.dart';
import 'package:mathcrush/pages/HomeDesign.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeDesign(),
            ),
          );
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class Dia {
  BuildContext context;
  String title;
  String per;
  IconData icon;

  String message;
  Color titleTextColor;
  Color messageTextColor;
  Color buttonColor;
  Color buttonTextColor;
  Color bgColor;
  String buttonText;
  Dia({
    this.context,
    this.per,
    this.title,
    this.icon,
    this.message,
    this.titleTextColor,
    this.messageTextColor,
    this.buttonColor,
    this.buttonText,
    this.buttonTextColor,
    this.bgColor,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor ?? Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon ?? Icons.check,
                color: Colors.red,
                size: 90.0,
              ),
              Flexible(
                  child: Text(
                title ?? "Congratulations",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: titleTextColor ?? Colors.black,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  message ?? "You Got $per %, You Promoted to Next Level",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: messageTextColor ?? Colors.black),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0))),
                color: buttonColor ?? Colors.black,
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomeDesign(),
                  //   ),
                  //   (Route<dynamic> route) => false,
                  // );

                  Navigator.of(context).pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      buttonText ?? "Next",
                      style: TextStyle(color: buttonTextColor ?? Colors.white),
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

class Dia2 {
  BuildContext context;
  String title;
  String per;
  IconData icon;

  String message;
  Color titleTextColor;
  Color messageTextColor;
  Color buttonColor;
  Color buttonTextColor;
  Color bgColor;
  String buttonText;
  Dia2({
    this.context,
    this.per,
    this.title,
    this.icon,
    this.message,
    this.titleTextColor,
    this.messageTextColor,
    this.buttonColor,
    this.buttonText,
    this.buttonTextColor,
    this.bgColor,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor ?? Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon ?? Icons.check,
                color: Colors.red,
                size: 90.0,
              ),
              Flexible(
                  child: Text(
                title ?? "Congratulations",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  color: titleTextColor ?? Colors.black,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Text(
                  message ?? "You Got $per %, You Promoted to Next Level",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: messageTextColor ?? Colors.black),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9.0))),
                color: buttonColor ?? Colors.black,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context2) => HomeDesign(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      buttonText ?? "Next",
                      style: TextStyle(color: buttonTextColor ?? Colors.white),
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
