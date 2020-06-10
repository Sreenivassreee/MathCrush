import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mathcrush/models/alreadyDataFromServer.dart';
import 'package:mathcrush/pages/error.dart';
import 'package:mathcrush/resources/Global.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final usersReference = Firestore.instance.collection("Users");

class Fire {
  static Future<alreadyDataFromServer> initialCheck({user, context}) async {
    String _mess;

    try {
      print("currentAccount.id ${user.uid}");
      DocumentSnapshot documentSnapshot =
          await usersReference.document(user.uid).get();

      if (documentSnapshot.exists) {
        _mess = "AlreadyUser";
        documentSnapshot = await usersReference.document(user.uid).get();
        return alreadyDataFromServer.fromMap(documentSnapshot);
      } else {
        usersReference.document(user.uid).setData({
          "id": user.uid,
          "name": user.displayName,
          "email": user.email,
          "photoUrl": user.photoUrl,
          "mobile": " ",
          "state": " ",
          "qualification": " ",
          "currentLevel": 1,
          "currentScore": 100,
          "about": " ",
          "pin": " "
        });
        documentSnapshot = await usersReference.document(user.uid).get();
      }
      return alreadyDataFromServer.fromMap(documentSnapshot);
    } catch (e) {
      ErrorPage(context: context);
      logOut(context);
    }
  }

  static Future<alreadyDataFromServer> fireBaseUserData({id, context}) async {
    DocumentSnapshot document = await usersReference.document(id).get();

    print(" id in 1 $id");

    if (document.exists) {
      print("Document is There");
      DocumentSnapshot documentSnapshot =
          await usersReference.document(id).get();
      return alreadyDataFromServer.fromMap(documentSnapshot);
    } else {
      print("No Document");
      return null;
    }
  }

  static Future<String> fireUpdaeScoreAndLevel(
      String id, int upLevel, int upScore) async {
    String _mess;
    // DocumentSnapshot documentSnapshot =
    //     await usersReference.document(id).get();

    // if (documentSnapshot.exists) {
    // _mess = "AlreadyUser";
    //   documentSnapshot = await usersReference.document(user.id).get();
    //   return alreadyDataFromServer.fromMap(documentSnapshot);
    // } else {

    try {
      usersReference.document(id).updateData({
        "currentLevel": upLevel,
        "currentScore": upScore,
      });
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  static Future<String> fireUpdaeScore(String id, int upScore) async {
    String _mess;

    try {
      usersReference.document(id).updateData({
        "currentScore": upScore,
      });
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  static Future<String> updateLevelPercentageFire(
      String id, int level, String per) async {
    String _mess;
    print("Per $per");
    DocumentSnapshot documentSnapshot = await usersReference
        .document(id)
        .collection("LevelPercentages")
        .document(level.toString())
        .get();
    if (documentSnapshot.exists) {
      try {
        usersReference
            .document(id)
            .collection("LevelPercentages")
            .document(level.toString())
            .updateData({
          "level": level,
          "percentage": per.toString(),
        });
        _mess = "Sucess";
      } catch (e) {
        _mess = "Failed";
      }
    } else {
      try {
        usersReference
            .document(id)
            .collection("LevelPercentages")
            .document(level.toString())
            .setData({
          "level": level,
          "percentage": per.toString(),
        });
        _mess = "Sucess";
      } catch (e) {
        _mess = "Failed";
      }
    }

    return _mess;
  }

  // fetchLevels(id) {
  //   Future<QuerySnapshot> data=usersReference.document(id).collection("LevelPercentages").getDocuments();
  //   if(data!=null){
  //     levelPer.fromMap(QuerySnapshot).toList();
  //   }
  // }

  static Future<String> updateProfile({
    String userId,
    String name,
    String mobile,
    String pin,
    String state,
    String quali,
  }) async {
    String _mess;
    try {
      usersReference.document(userId).updateData({
        "name": name,
        "mobile": mobile,
        "state": state,
        "qualification": quali,
        "pin": pin,
      });

      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }

  static Future<String> saveAbout({String userId, String about}) async {
    print(userId);
    String _mess;
    try {
      usersReference.document(userId).updateData(
        {
          "about": about.toString(),
        },
      );
      _mess = "Sucess";
    } catch (e) {
      _mess = "Failed";
    }
    return _mess;
  }
}
