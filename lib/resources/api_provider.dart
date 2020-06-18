import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mathcrush/models/homeLearn.dart';
import '../models/category.dart';
import '../models/question.dart';

// var db = new Mysql();
final levelReference = Firestore.instance.collection("Levels");
String _level;
Future<List<Question>> getQuestions(Category category) async {
  List<Question> list = List();

  List<Question> list2 = List();
  _level = category.level;
  try {
    DocumentSnapshot documentSnapshot =
        await levelReference.document("Level-" + _level).get();

    // .getDocuments();
    // documentSnapshot.documents.forEach((e) {
    //   Question levelP = Question.fromMap(e.data);
    //   list.add(levelP);
    // });
    // print(documentSnapshot.data);
    // var a = documentSnapshot.data["Level-1"];
    // var b = documentSnapshot.data["Level-1"][0]["CA"];
    // var c = documentSnapshot.data["Level-1"][0]["ICA1"];
    // var d = documentSnapshot.data["Level-1"][0]["ICA2"];
    // var e = documentSnapshot.data["Level-1"][0]["ICA3"];

    // print("documentSnapshot.data $b");
    // print("documentSnapshot.data $c");
    // print("documentSnapshot.data $d");
    // print("documentSnapshot.data $e");

    for (int i = 0;
        documentSnapshot.data["Level-" + _level][i]["Q"] != null;
        i++) {
      if (documentSnapshot.data["Level-" + _level][i] == null) {
        print("hi");
      } else {
        list.add(Question(
          question: documentSnapshot.data["Level-" + _level][i]["Q"].toString(),
          correctAnswer:
              documentSnapshot.data["Level-" + _level][i]["CA"].toString(),
          incorrectAnswer1:
              documentSnapshot.data["Level-" + _level][i]["ICA1"].toString(),
          incorrectAnswer2:
              documentSnapshot.data["Level-" + _level][i]["ICA2"].toString(),
          incorrectAnswer3:
              documentSnapshot.data["Level-" + _level][i]["ICA3"].toString(),
        ));
      }
    }
  } catch (e) {
    print(e.toString());
  }
  for (var i = 0; i <= 10; i++) {
    list2.add(list[i]);
    list2.shuffle();
    print(list2.length);
  }
  return list2;
}

// final levelReference = Firestore.instance.collection("AllLevels");

// String _level;
// Future<List<Question>> getQuestions(Category category) async {
//   List<Question> list = List();
//   List<Question> list2 = List();
//   _level = category.level;
//   try {
//     QuerySnapshot documentSnapshot = await levelReference
//         .document("M5xgqSw5RA2VaBkQEP5N")
//         .collection("Level-" + _level)
//         .getDocuments();
//     documentSnapshot.documents.forEach((e) {
//       Question levelP = Question.fromMap(e.data);
//       list.add(levelP);
//     });
//   } catch (e) {}
//   for (var i = 1; i <= 15; i++) {
//     list2.add(list[i]);
//   }
//   list2.shuffle();
//   print(list.length);
//   print(list2.length);
//   return list2;
// }

Learn learn = Learn();

Future<Learn> getLearn(Category category) async {
  _level = category.level;
  try {
    QuerySnapshot learnDocument = await levelReference
        .document("M5xgqSw5RA2VaBkQEP5N")
        .collection("Level-" + _level)
        .document("learn")
        .collection("home")
        .getDocuments();

    // print(learnDocument.documents[0]['pic']);

    if (learnDocument.documents == null) {
      return Learn();
    } else {
      return Learn(
        pic: learnDocument.documents[0]['pic'],
        video: learnDocument.documents[0]['video'],
      );
    }
  } catch (e) {
    print("Error");
    return Learn();
  }
}
