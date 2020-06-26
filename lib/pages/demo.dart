import 'package:flutter/material.dart';

class demo extends StatelessWidget {
  String url;
  demo(this.url);
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
            url,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
