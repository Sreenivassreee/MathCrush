import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';

class demo extends StatefulWidget {
  @override
  _demoState createState() => _demoState();
}

class _demoState extends State<demo> {
  FirebaseStorage _storage = FirebaseStorage.instance;

  //Creating a global Variable
  StorageReference storageReference = FirebaseStorage.instance.ref();
  File _image;
  var downloadUrl1;
  var url;

  void addImageToFirebase() async {
    //CreateRefernce to path.
    StorageReference ref = storageReference.child("yourstorageLocation/");

    //StorageUpload task is used to put the data you want in storage
    //Make sure to get the image first before calling this method otherwise _image will be null.
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });

    StorageUploadTask storageUploadTask =
        ref.child("image1.jpg").putFile(_image);

    if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {
      storageUploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot =
          await storageUploadTask.onComplete;

      downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();
      setState(() {
        url = downloadUrl1.toString();
      });

      //Here you can get the download URL when the task has been completed.
      print("Download URL " + downloadUrl1.toString());
    } else {
      //Catch any cases here that might come up like canceled, interrupted
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hi"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            addImageToFirebase();
          }),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: _image == null
                  ? Container()
                  : Container(
                      child: Image.file(_image),
                    ),
            ),
            Expanded(
              flex: 1,
              child: url == null
                  ? Container()
                  : Container(
                      child: Image.network(url),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
