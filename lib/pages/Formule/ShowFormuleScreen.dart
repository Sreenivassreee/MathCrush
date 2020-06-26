import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowFormuleScreen extends StatelessWidget {
  var data;
  ShowFormuleScreen(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          data["topic"],
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "arial",
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              fadeInDuration: Duration(seconds: 1),
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: data["url"],
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            //  Image.network(
            // data["url"],
            // fit: BoxFit.fitWidth,
            // ),
          ),
        ),
      ),
    );
  }
}
