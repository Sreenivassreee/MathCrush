import 'package:flutter/material.dart';

class demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hi"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/math-crush-e3ec2.appspot.com/o/1.png?alt=media&token=f83ee5e9-6037-46f8-acb1-570a2a233a8e",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
